{
  inputs = {
    # core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # special system stuff
    disko = { url = "github:nix-community/disko"; inputs.nixpkgs.follows = "nixpkgs"; };
    nixos-wsl = { url = "github:nix-community/NixOS-WSL/main"; inputs.nixpkgs.follows = "nixpkgs"; };
    home-manager = { url = "github:nix-community/home-manager/release-25.11"; inputs.nixpkgs.follows = "nixpkgs"; };

    # extra
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,

      disko,
      nixos-wsl,
      home-manager,

      nix-flatpak,
      nix-vscode-extensions,
      firefox-addons,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
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
            repoRoot = self;
          };
          modules = [
            {
              nixpkgs.overlays = [
                nix-vscode-extensions.overlays.default
                firefox-addons.overlays.default
              ];
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.pierre = import ./modules/home/pierre/home.nix;
              home-manager.extraSpecialArgs = {
                inherit pkgs-unstable;
                secrets = import ./vars/secrets.nix { inherit (nixpkgs) lib; };
              };
              home-manager.sharedModules = [
                nix-flatpak.homeManagerModules.nix-flatpak
              ];
            }
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
          specialArgs = {
            secrets = import ./vars/secrets.nix { inherit (nixpkgs) lib; };
          };
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/r7game-wsl/configuration.nix
          ];
        };

      };
    };
}
