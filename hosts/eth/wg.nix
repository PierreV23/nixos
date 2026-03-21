{ secrets, ... }:
{
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.0.0.1/24" ];
    listenPort = secrets.eth.wg.port;

    privateKey = secrets.eth.wg.private_key;

    peers = [
      {
        # mediaserver
        publicKey = secrets.mediaserver.wg.public_key;
        allowedIPs = [ secrets.mediaserver.wg.subnet_ip ];
      }
      {
        # pixel 10
        publicKey = secrets.pixel10.wg.public_key;
        allowedIPs = [ secrets.pixel10.wg.subnet_ip ];
      }
      {
        # t480s
        publicKey = secrets.t480s.wg.public_key;
        allowedIPs = [ secrets.t480s.wg.subnet_ip ];
      }
      {
        # r5homeserver
        publicKey = secrets.r5homeserver.wg.public_key;
        allowedIPs = [ secrets.r5homeserver.wg.subnet_ip ];
      }
    ];
  };
}
