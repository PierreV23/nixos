{
    inputs  ={
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/release-25.05";
        nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
        nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nix-flatpak, nix-vscode-extensions, firefox-addons, ...}:
        let
        system = "x86_64-linux";
        pkgs-unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
        in {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./configuration.nix
                nix-flatpak.nixosModules.nix-flatpak
                home-manager.nixosModules.home-manager
                {
                    nixpkgs.config.allowUnfree = true;
                    nixpkgs.overlays = [
                        nix-vscode-extensions.overlays.default
                        firefox-addons.overlays.default
                    ];
                }
                {
                    home-manager.backupFileExtension = "backup";
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.extraSpecialArgs = {
                        inherit pkgs-unstable;
                    };
                    home-manager.users.pierre = {
                        imports = [
                            nix-flatpak.homeManagerModules.nix-flatpak
                            ./home/pierre/home.nix
                        ];
                    };
                }
            ];
        };
    };
}
