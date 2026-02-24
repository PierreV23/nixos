{ secrets, ... }:
{
  networking.wireguard.interfaces.wg0 = {
    ips = [ secrets.wg.mediaserver.subnet_ip ];

    privateKey = secrets.wg.mediaserver.private_key;

    peers = [
      {
        publicKey = secrets.wg.eth.public_key;
        endpoint = secrets.wg.eth.ip_port;
        allowedIPs = [ "10.0.0.0/24" ];
        persistentKeepalive = 25;
      }
    ];
  };

  networking.nameservers = [ "1.1.1.1" ];
}
