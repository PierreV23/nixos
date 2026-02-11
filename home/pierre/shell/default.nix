{ pkgs, ... }:
{
  imports = [
    ./zsh # zsh will take precedence over bash (not due to order, i just tell zsh to force itself)
    ./bash.nix
    ./kitty.nix
  ];

  # Kinda like 'cat' but with code/config highlighting
  programs.bat.enable = true;

  # Fuzzy finder. Used for viewing history (ctrl+r) and searching files (ctrl+t) inside terminal.
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--height 40%"
      "--border"
    ];
    fileWidgetOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}'" ]; # Preview files with 'bat'
  };

  home.shellAliases = {
    lla = "ls -la";
    latr = "ls -latr";
    please = "sudo !!";
    ".." = "cd ..";
    "..." = "cd ../..";
    grep = "grep --color=auto";
    diff = "diff --color=auto";
  };

  home.packages = [
    # insane alias coding 😎
    (pkgs.writeShellScriptBin "cbc" ''
      ${pkgs.ansifilter}/bin/ansifilter | wl-copy "$@"
    '')
    (pkgs.writeShellScriptBin "cbp" "wl-paste \"$@\"")
  ];
}
