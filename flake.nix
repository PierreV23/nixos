{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { 
      nixpkgs, 
      #nixpkgs-unstable, 
       disko, 
     ... }:
    let
      system = "x86_64-linux";
      #pkgs-unstable = import nixpkgs-unstable {
      #  inherit system;
      #  config.allowUnfree = true;
      #};
      secrets = import ./vars/secrets.nix { inherit (nixpkgs) lib; };
    in
    {
      nixosConfigurations = {

        mediaserver = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit secrets; };
          modules = [
            disko.nixosModules.disko
            ./hosts/mediaserver/disk-config.nix
            ./hosts/mediaserver/configuration.nix
          ];
        };

        # TODO: rename to t480s
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          #specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./hosts/t480s/configuration.nix
          ];
        };

      };
    };
}
