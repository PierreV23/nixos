{secrets, ...}:
{
  # ssh
  services.openssh.enable = true;

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