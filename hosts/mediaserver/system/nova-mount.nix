{
  pkgs,
  secrets,
  config,
  ...
}:
let
  rcloneConfigSource = pkgs.writeText "nova.conf" ''
    [nova-sftp]
    type = sftp
    host = ${secrets.nova.ip}
    user = media
    key_file = /root/.ssh/id_ed25519
    chunk_size = 255k
    idle_timeout = 0
    concurrency = 10

    [nova-media]
    type = crypt
    remote = nova-sftp:/data
    filename_encryption = standard
    directory_name_encryption = true
    password = ${secrets.mediaserver.nova_media_password}
    password2 = ${secrets.mediaserver.nova_media_password2}
  '';

  rcloneConfig = "/run/rclone/nova.conf";
  mountPoint = "/mnt/data";
in
{
  environment.systemPackages = [ pkgs.rclone ];

  programs.fuse.userAllowOther = true;

  systemd.tmpfiles.rules = [
    "d /run/rclone        0700 root root -"
    "d ${mountPoint}      0755 root root -"
    "d /var/cache/rclone  0755 root root -"
    "f /var/log/rclone-nova.log 0644 root root -"
  ];

  systemd.services.docker = {
    after = [ "rclone-nova.service" ];
    requires = [ "rclone-nova.service" ];
    unitConfig.RequiresMountsFor = "/mnt/data";
  };

  systemd.services.rclone-nova = {
    description = "rclone mount: nova-media → ${mountPoint}";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    startLimitIntervalSec = 300;
    startLimitBurst = 5;

    serviceConfig = {
      Type = "notify";
      TimeoutStartSec = "180s";
      ExecStartPre = "${pkgs.coreutils}/bin/install -m 600 ${rcloneConfigSource} ${rcloneConfig}";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount nova-media: ${mountPoint} \
          --config=${rcloneConfig} \
          --cache-dir=/var/cache/rclone \
          --allow-other \
          --vfs-cache-mode=full \
          --vfs-cache-max-size=100G \
          --vfs-cache-min-free-space=10G \
          --vfs-cache-max-age=48h \
          --vfs-read-chunk-size=32M \
          --vfs-read-chunk-size-limit=512M \
          --vfs-read-ahead=256M \
          --vfs-cache-poll-interval=60s \
          --transfers=1 \
          --buffer-size=256M \
          --dir-cache-time=72h \
          --rc \
          --rc-addr=localhost:5572 \
          --rc-no-auth \
          --timeout=2m \
          --contimeout=30s \
          --retries=3 \
          --low-level-retries=5 \
          --retries-sleep=1s \
          --log-level=DEBUG \
          --log-file=/var/log/rclone-nova.log
      '';
      ExecStartPost = "${pkgs.bash}/bin/bash -c 'sleep 3 && ${pkgs.curl}/bin/curl -sf -X POST \"http://localhost:5572/vfs/refresh?recursive=true&_async=true\" || true'";
      ExecStop = "${pkgs.util-linux}/bin/umount -l ${mountPoint}";
      Restart = "always";
      RestartSec = "15s";
      KillMode = "process";
      TimeoutStopSec = "60s";
    };
  };
}