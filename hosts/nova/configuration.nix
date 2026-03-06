{
  modulesPath,
  pkgs,
  lib,
  secrets,
  ...
}:
{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
    ./system
  ];

  hardware.enableRedistributableFirmware = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.11";
}
