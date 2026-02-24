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

    # render folder structure
    tree

    # json parser
    jq

    # python package manager
    uv

    # mktmp, among other things
    coreutils

    # ts
    moreutils
  ];

  nix = [
    home-manager
    nixfmt-rfc-style
    nixfmt-tree
  ];
}
