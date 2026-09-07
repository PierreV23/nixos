{
  config,
  pkgs,
  secrets,
  ...
}:
let
  fwd = srcPort: destHost: destPort: proto: {
    inherit proto;
    sourcePort = srcPort;
    destination = "${destHost}:${toString destPort}";
  };

  jellyfin = {
    wg_ip = secrets.mediaserver.wg.local_ip;
    wg_port = secrets.mediaserver.services.jellyfin.port;
    public_port = secrets.eth.redirects.jellyfin.public_port;
  };

  minecraft = {
    wg_ip = "10.0.0.4";
    wg_port = 25566;
    public_port = 25565;
  };
in
{
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  networking.nat = {
    enable = true;
    externalInterface = "ens3";
    internalIPs = [ "10.0.0.0/24" ];
    internalInterfaces = [ "wg0" ];
    forwardPorts = [
      (fwd jellyfin.public_port jellyfin.wg_ip jellyfin.wg_port "tcp")
      (fwd minecraft.public_port minecraft.wg_ip minecraft.wg_port "tcp")
    ];
  };

  networking.firewall = {
    checkReversePath = false;
    trustedInterfaces = [ "wg0" ];
    allowedTCPPorts = map (r: r.sourcePort) config.networking.nat.forwardPorts;
    extraCommands = ''
      iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
    '';
    extraStopCommands = ''
      iptables -t nat -D POSTROUTING -o wg0 -j MASQUERADE || true
    '';
  };
}
