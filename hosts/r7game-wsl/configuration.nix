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

  

    # NVIDIA-GPU in Docker onder WSL (Windows-driver, geen Linux-driver)
  wsl.useWindowsDriver = true;
  hardware.nvidia-container-toolkit = {
    enable = true;
    suppressNvidiaDriverAssertion = true;
  };
  virtualisation.docker.daemon.settings.features.cdi = true;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkg.pname or (builtins.parseDrvName pkg.name).name) [
    "nvidia-x11" "nvidia-settings" "nvidia-persistenced"
  ];

  virtualisation.libvirtd.onShutdown = "shutdown";
  
  virtualisation.docker.enable = true;
  users.users.nixos.extraGroups = [ "docker" "libvirtd" ];

  virtualisation.libvirtd.enable = true;

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
