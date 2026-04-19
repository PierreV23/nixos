{ secrets, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
    extraConfig = ''
      Match User media
        ChrootDirectory /mnt/data/media
        ForceCommand internal-sftp
        AllowTcpForwarding no
        X11Forwarding no
      Match User pierre
        ChrootDirectory /mnt/data/pierre
        ForceCommand internal-sftp
        AllowTcpForwarding no
        X11Forwarding no
    '';
  };

  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h";
      overalljails = true;
    };
    ignoreIP = [
      "10.0.0.0/8"
      "192.168.0.0/16"
      "172.16.0.0/12"
      secrets.home_ip
    ];
  };

  services.openssh.settings = {
    MaxStartups = "10:30:100";
  };

  users.users.root = {
    hashedPassword = secrets.nova.root_password;
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
      secrets.ssh.r7game-wsl.nixos.public_key
      secrets.ssh.t480s.public_key
    ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/data/media      0755 root  root  -"
    "d /mnt/data/media/data 0755 media media -"
    "d /mnt/data/pierre      0755 root  root  -"
    "d /mnt/data/pierre/data 0755 pierre users -"
  ];

  users.users.media = {
    isSystemUser = true;
    group = "media";
    home = "/mnt/data/media";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = [ secrets.ssh.mediaserver.root.public_key ];
  };
  users.groups.media = { };

  users.users.pierre = {
    isNormalUser = true;
    home = "/mnt/data/pierre";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
      secrets.ssh.r7game-wsl.nixos.public_key
      secrets.ssh.t480s.public_key
    ];
  };
}
