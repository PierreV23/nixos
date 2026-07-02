{ config, inputs, ... }:
{
  flake.nixosConfigurations.e14g7 = inputs.nixpkgs-2605.lib.nixosSystem {
    modules = [
      # base host configs
      ../../hosts/e14g7/configuration.nix
      ../../hosts/e14g7/hardware-configuration.nix

      # user account as dendritic
      config.flake.modules.nixos.pierre

      inputs.home-manager-2605.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.pierre.imports = [
          config.flake.modules.homeManager.pierre
          config.flake.modules.homeManager.git
        ];
      }
    ];
  };
}
