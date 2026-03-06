{ secrets, ...}:
{
  # ssh
  services.openssh.enable = true;

  # static network config
  networking.useDHCP = false;
  networking.interfaces.ens3 = {
    useDHCP = false;
    ipv4.addresses = [{
        address = secrets.eth.ip;
        prefixLength = 24;
    }];
  };
  networking.defaultGateway = secrets.eth.gateway;
  networking.nameservers = [ "1.1.1.1" "8.8.8.8" ];

  # periodically ping gateway, otherwise for some reason the vps loses connection
  systemd.services.network-keepalive = {
  description = "Keep network ARP alive";
  wantedBy = [ "multi-user.target" ];
  after = [ "network-online.target" ];
  serviceConfig = {
      Type = "simple";
      Restart = "always";
      ExecStart = "/run/current-system/sw/bin/ping -i 60 ${secrets.eth.gateway}";
    };
  };

  networking.hostName = "eth";
}