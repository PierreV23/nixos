# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./assh.nix
    ./programs.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    git
    git-crypt
  ];

  networking.hostName = "r7game-wsl";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11"; # do not touch
}
