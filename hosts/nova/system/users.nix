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

  users.users.root = {
    hashedPassword = secrets.nova.root_password;
    openssh.authorizedKeys.keys = [ secrets.ssh.r7game.public_key ];
  };

  systemd.tmpfiles.rules = [
    "d /mnt/data/media  0755 root root -"
    "d /mnt/data/pierre 0755 root root -"
  ];

  users.users.media = {
    isSystemUser = true;
    group = "media";
    home = "/mnt/data/media";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = [ secrets.ssh.mediaserver.root.public_key ];
  };
  users.groups.media = {};

  users.users.pierre = {
    isNormalUser = true;
    home = "/mnt/data/pierre";
    shell = "${pkgs.shadow}/bin/nologin";
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
    ];
  };
}