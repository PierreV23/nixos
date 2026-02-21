{
  modulesPath,
  pkgs,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./system
  ];

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  networking.hostName = "mediaserver";
  networking.networkmanager.enable = true;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.PermitRootLogin = "prohibit-password";
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.11";
}
