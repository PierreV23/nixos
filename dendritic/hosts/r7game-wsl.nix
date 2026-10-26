{
  config,
  inputs,
  lib,
  ...
}:
let
  flakeCfg = config.flake;
in
{
  flake.nixosConfigurations.r7game-wsl = inputs.nixpkgs-2605.lib.nixosSystem {
    specialArgs = {
      secrets = import ../../vars/secrets.nix { inherit lib; };
      repoRoot = inputs.self;
    };
    modules = [
      inputs.nixos-wsl-2605.nixosModules.default
      ../../hosts/r7game-wsl/configuration.nix
      { nixpkgs.hostPlatform = "x86_64-linux"; }

      flakeCfg.modules.nixos.pierre
      flakeCfg.modules.nixos.zsh
      flakeCfg.modules.nixos.overlays
      flakeCfg.modules.nixos.nix_ld
      flakeCfg.modules.nixos.virtualisation
      flakeCfg.modules.nixos.sudo
      flakeCfg.modules.nixos.cl_packages
      flakeCfg.modules.nixos.nix_packages
      flakeCfg.modules.nixos.auto-cleanup


      inputs.home-manager-2605.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bak";
        home-manager.users.pierre.imports = [
          {
            home.stateVersion = lib.mkForce "26.05";
          }
          flakeCfg.modules.homeManager.pierre
          flakeCfg.modules.homeManager.git
          flakeCfg.modules.homeManager.direnv
          flakeCfg.modules.homeManager.zsh
          flakeCfg.modules.homeManager.shell
          flakeCfg.modules.homeManager.atuin
          flakeCfg.modules.homeManager.vm
          flakeCfg.modules.homeManager.cl_packages
          flakeCfg.modules.homeManager.nix_packages
          flakeCfg.modules.homeManager.kitty
        ];
      }
    ];
  };
}
