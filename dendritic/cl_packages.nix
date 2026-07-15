{ ... }:
let
  cliPackages = pkgs: with pkgs; [
    git
    git-crypt

    #@ shell
    zsh

    #@ fetching
    wget
    curl

    #@ folder tree
    tree

    #@ json parser
    jq

    #@ mktemp and more
    coreutils

    #@ ts and more
    moreutils

    #@ system monitoring
    htop
    s-tui
    iotop
    iftop

    #@ terminal multiplexer
    screen

    #@ storage
    ncdu

    #@ compression
    zip
    unzip

    #@ python
    python313
    uv #@ package manager

    #@ misc cli
    bc
    datamash
    openssl
  ];

  nixPackages = pkgs: with pkgs; [
    # home-manager
    nixfmt
    nixfmt-tree
  ];
in
{
  flake.modules.nixos.cl_packages = { pkgs, ... }: {
    environment.systemPackages = cliPackages pkgs;
  };

  flake.modules.homeManager.cl_packages = { pkgs, ... }: {
    home.packages = cliPackages pkgs;
  };

  flake.modules.nixos.nix_packages = { pkgs, ... }: {
    environment.systemPackages = nixPackages pkgs;
  };

  flake.modules.homeManager.nix_packages = { pkgs, ... }: {
    home.packages = nixPackages pkgs;
  };
}