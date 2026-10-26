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
      ../../modules/common/gc.nix
      { nixpkgs.hostPlatform = "x86_64-linux"; }

      flakeCfg.modules.nixos.pierre

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
        ];
      }
    ];
  };
}
