{
  pkgs,
  secrets,
  config,
  ...
}:
let
  # Write the config to the Nix store (read-only), then copy to a writable path at runtime
  rcloneConfigSource = pkgs.writeText "nova.conf" ''
    [nova-sftp]
    type = sftp
    host = ${secrets.nova.ip}
    user = media
    key_file = /root/.ssh/id_ed25519
    chunk_size = 255k

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

  systemd.services.rclone-nova = {
    description = "rclone mount: nova-media → ${mountPoint}";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "notify";
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
          --vfs-cache-poll-interval=10s \
          --buffer-size=256M \
          --dir-cache-time=15s \
          --rc \
          --rc-addr=localhost:5572 \
          --rc-no-auth \
          --log-level=INFO \
          --log-file=/var/log/rclone-nova.log
      '';
      ExecStop = "${pkgs.util-linux}/bin/umount -l ${mountPoint}";
      Restart = "on-failure";
      RestartSec = "10s";
      KillMode = "process";
      TimeoutStopSec = "60s";
    };
  };
}
