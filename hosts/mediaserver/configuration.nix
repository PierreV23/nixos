{ modulesPath, pkgs, secrets, ... }:
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

  users.users.sjourd = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    secrets.ssh.r7game.public_key
  ];

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.11";
}
