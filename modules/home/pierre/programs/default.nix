{ pkgs, ... }:
{
  imports = [
    ./vscode
    ./firefox
    ./flatpak.nix
    ./signal.nix
    ./zed_editor.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    zapzap # Whatsapp web wrapper
    typst # Typst cpompiler
    tinymist # Typst language server
    # nixd # nix language server
    uv # Python package manager (suite-ish). If it doesnt work try?:
    # (uv.overrideAttrs (old: {
    #   nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ makeWrapper ];
    #   postInstall = (old.postInstall or "") + ''
    #     wrapProgram $out/bin/uv \
    #       --prefix LD_LIBRARY_PATH : "${stdenv.cc.cc.lib}/lib"
    #   '';
    # }))
    python313
    virt-viewer # Connect to my libvirt VMs using 'Spice'
    libreoffice-still # Office suite
    bc # Command like calculator
    datamash # Transposing data in terminal
    openssl # For checking connection accesisability and certification checks

    moonlight-qt # Moonlight: connects to remote desktop sunlight servers

    wl-clipboard # wl-copy/wl-paste

    # vm stuff
    libvirt
    virt-manager # viewing VMs
    spice # view/display manager thingy for VMs
    spice-gtk
    spice-protocol
    vagrant

    microsoft-edge
  ];
}
