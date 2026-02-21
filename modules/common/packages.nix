# packages.nix
{ pkgs }:
with pkgs;
{
  common = [
    git
    git-crypt
    
    # shell
    zsh

    # fetching
    wget
    curl
  ];

  nix = [
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
  ];
}
