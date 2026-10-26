{ inputs, lib, ... }:
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
      {
        nixpkgs.hostPlatform = "x86_64-linux";
      }
    ];
  };
}
