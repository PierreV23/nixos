{ ... }:
{
  home.stateVersion = "25.05";

  # home.keyboard = { # doesnt seem to do anything, gnome seems to override this
  #   layout = "us";
  #   variant = "altgr-intl";
  # };


  # i think this one does nothing
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Adwaita:dark";
  };

  # works for systemd electron apps
  systemd.user.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    GTK_THEME = "Adwaita:dark";
  };

  imports = [
    ./applications.nix
    ./gnome.nix
    ./shell
  ];
}
