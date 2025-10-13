{ config, pkgs, ... }:
{
  home.stateVersion = "25.05";

  # home.keyboard = { # doesnt seem to do anything, gnome seems to override this
  #   layout = "us";
  #   variant = "altgr-intl";
  # };

  imports = [
    ./applications.nix
    ./gnome.nix
    ./shell.nix
  ];
}