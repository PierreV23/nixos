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
    in
    {
      nixosConfigurations = {

        mediaserver = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            disko.nixosModules.disko
            ./mediaserver/disk-config.nix
            ./mediaserver/configuration.nix
          ];
        };

        # TODO: rename to t480s
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          #specialArgs = { inherit pkgs-unstable; };
          modules = [
            ./t480s/configuration.nix
          ];
        };

      };
    };
}
