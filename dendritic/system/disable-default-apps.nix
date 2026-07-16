{ ... }:
{
  flake.modules.nixos.disable-default-apps =
    { pkgs, ... }:
    {
      environment.gnome.excludePackages = with pkgs; [
        decibels
        epiphany
        gnome-connections
        gnome-contacts
        gnome-characters
        gnome-maps
        gnome-music
        gnome-tecla
        gnome-tour
        gnome-user-docs
        showtime
        simple-scan
        yelp
      ];

      services.xserver.excludePackages = [ pkgs.xterm ];

      documentation.nixos.enable = false;
    };
}
