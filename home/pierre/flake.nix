{
  description = "Pierre's Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nix-flatpak,
      nix-vscode-extensions,
      firefox-addons,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nix-vscode-extensions.overlays.default
          firefox-addons.overlays.default
        ];
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      homeConfigurations.pierre = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          nix-flatpak.homeManagerModules.nix-flatpak
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
      };
    };
}
