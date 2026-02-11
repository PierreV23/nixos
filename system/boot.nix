{ ... }:
{
  # (both are) needed to get the 'nixos generations' view during boot
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
