{ ... }:
{
  flake.modules.nixos.nix_ld = { pkgs, ... }: {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc # c(pp) compiler libraries
        openssl
        libssh
        libxml2
        #@ file stuff
        attr
        acl
        util-linux
        #@ compression
        bzip2
        libsodium
        xz
        zlib
        zstd
        systemd
      ];
    };
  };
}