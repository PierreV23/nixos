{ pkgs, pkgs-unstable, ... }:
{
  # Code/text editor written in rust(lang)
  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;

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
