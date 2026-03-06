{ secrets, ... }:
{
  networking.hostName = "nova";
  networking.useDHCP = false;
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = secrets.nova.ip;
      prefixLength = 24;
    }
  ];
  networking.defaultGateway = secrets.nova.gateway;
  networking.nameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];
}
