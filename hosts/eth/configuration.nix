# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, secrets, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./users.nix
      ./networking.nix
      ./wg.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  system.stateVersion = "25.11"; # dont touch
}