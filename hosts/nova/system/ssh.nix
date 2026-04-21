{secrets, ...}:
{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
    settings.ClientAliveInterval = 30;
    settings.ClientAliveCountMax = 6;
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
}
