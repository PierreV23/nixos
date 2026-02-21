{ ... }:
{
  imports = [
    ./boot.nix
    ./desktop.nix
    ./flatpak.nix
    ./locale.nix
    ./location.nix
    ./networking.nix
    ./programs.nix
    ./users.nix
    ./virtualization.nix
  ];
}
