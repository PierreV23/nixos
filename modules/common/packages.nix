# packages.nix
{ pkgs }:
with pkgs;
{
  common = [
    git
    git-crypt
    zsh
  ];

  nix = [
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
  ];
}
