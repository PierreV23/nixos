{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      #nixpkgs-unstable,
      disko,
      nixos-wsl,
      ...
    }:
    let
      system = "x86_64-linux";
      #pkgs-unstable = import nixpkgs-unstable {
      #  inherit system;
      #  config.allowUnfree = true;
      #};
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations = {

        mediaserver = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            secrets = import ./vars/secrets.nix { inherit (nixpkgs) lib; };
            repoRoot = self;
          };
          modules = [
            disko.nixosModules.disko
            ./hosts/mediaserver/disk-config.nix
            ./hosts/mediaserver/configuration.nix
          ];
        };

        t480s = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            # inherit pkgs-unstable;
            repoRoot = self;
          };
          modules = [
            ./hosts/t480s/configuration.nix
          ];
        };

        nova = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            secrets = import ./vars/secrets.nix { inherit (nixpkgs) lib; };
          };
          modules = [
            disko.nixosModules.disko
            ./hosts/nova/disk-config.nix
            ./hosts/nova/configuration.nix
          ];
        };

        r7game-wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/r7game-wsl/configuration.nix
          ];
        };

      };
    };
}
