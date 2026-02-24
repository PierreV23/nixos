{ pkgs, ... }:
{
  networking.firewall = {
    enable = true;
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect/GSConnect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDE Connect/GSConnect
    ];
  };

  networking.hostName = "t480s"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect # supports plethora of vpn protocols afaik
      networkmanager-l2tp # WireGuard support
    ];
  };
}
