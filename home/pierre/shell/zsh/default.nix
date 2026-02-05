{ pkgs, lib, ... }:
{

  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";# TODO, dunno if this actually does anything :D
  };

  programs.starship.enableZshIntegration = lib.mkForce false; # should always be off, im using my own custom zsh logic
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-nix-shell"; # needed so that nix-shells enter with zsh rather than bash
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    initContent = builtins.readFile ./zsh-config.zsh;

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };
  };

  # enable fzf for zsh
  programs.fzf.enableZshIntegration = true;

  # set zsh as default kitty, force overwriting
  programs.kitty.settings.shell = lib.mkForce "${pkgs.zsh}/bin/zsh";
}
