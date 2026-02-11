{ pkgs, ... }:
{
  # shells
  # programs.bash.enable = true; # actually not needed (doesnt even build), always available on nixos system by default
  programs.zsh.enable = true;

  # to search packages: `nix search <>`
  environment.systemPackages = with pkgs; [
    git

    wireguard-tools

    # home manager cli
    home-manager

    # fetching (bark)
    curl
    wget

    networkmanagerapplet # network manager app

    quickemu # easy way to manage vms but iirc its kinda trash so i'll delete it (TODO)
  ];

  # dynamic libraries
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc # c(pp) compiler libraries

      openssl # ssl

      libssh # ssh

      libxml2 # xml parser

      # file stuff
      attr
      acl # acces control list (idk why i need this tbh)

      util-linux # core utils or smht

      # compression libraries
      bzip2
      libsodium
      xz
      zlib
      zstd

      systemd # idk if this is needed here but im too scared to delete it :eyes:
    ];
  };

}
