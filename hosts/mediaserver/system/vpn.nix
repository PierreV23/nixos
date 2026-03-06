{ secrets, ... }:
{
  networking.wireguard.interfaces.wg0 = {
    ips = [ secrets.mediaserver.wg.subnet_ip ];

    privateKey = secrets.mediaserver.wg.private_key;

    peers = [
      {
        publicKey = secrets.eth.wg.public_key;
        endpoint = secrets.eth.wg.ip_port;
        allowedIPs = [ "10.0.0.0/24" ];
        persistentKeepalive = 25;
      }
    ];
  };

  networking.nameservers = [ "1.1.1.1" ];
}
