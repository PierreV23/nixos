{ config, inputs, ... }:
{
  flake.nixosConfigurations.e14g7 = inputs.nixpkgs-2605.lib.nixosSystem {
    modules = [
      # base host configs
      ../../hosts/e14g7/configuration.nix
      ../../hosts/e14g7/hardware-configuration.nix

      # user account as dendritic
      config.flake.modules.nixos.pierre
      config.flake.modules.nixos.overlays

      inputs.home-manager-2605.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bak"; # overwrites already existing files
        home-manager.users.pierre.imports = [
          config.flake.modules.homeManager.pierre
          config.flake.modules.homeManager.git
          config.flake.modules.homeManager.firefox
          config.flake.modules.homeManager.vscode
        ];
      }
    ];
  };
}
