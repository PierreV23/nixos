{ pkgs, ... }:
{
  imports = [
    ./vscode
    ./firefox
    ./signal.nix
  ];

  # Flatpak is a quite popular 'appstore'. Flatpak has both official and 3rd party repacked apps
  services.flatpak = {
    update.auto.enable = false;
    uninstallUnmanaged = false;
    enable = true;
    packages = [
      "com.modrinth.ModrinthApp" # Minecraft mod(pack) manager
      "com.discordapp.Discord" # Chat app
      "app.zen_browser.zen" # Browser based off firefox
    ];
  };

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
  ];

  # Code/text editor written in rust(lang)
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "rust"
      "ssh-config"
      "zig"
      "git-firefly"
    ];
    extraPackages = [
      pkgs.nixd
      # zig
      # zls
      # zig-overlay.packages.${pkgs.system}."0.15.2"
      # zls-built
    ];
    userSettings = {

      load_direnv = "shell_hook";

      # Tell language servers to look up binaries in PATH
      lsp = {
        zls = {
          binary = {
            path_lookup = true;
          };
        };
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
            "..."
          ];
        };
        Zig = {
          # Zig/zls has to be installed (either: direnv, flake, system, within Zed; Via direnv/flake is reccomended to keep things version specific rather than having 1 global system version)
          language_servers = [ "zls" ];
        };
      };
    };
  };
}
