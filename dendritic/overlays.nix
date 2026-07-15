{ inputs, ... }:
{
  flake.modules.nixos.overlays = {
    nixpkgs.overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.firefox-addons.overlays.default
      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (prev.stdenv.hostPlatform) system;
          config.allowUnfree = true;
        };
      })
    ];
  };
}
