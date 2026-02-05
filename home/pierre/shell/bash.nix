{ pkgs, ... }:
{
  programs.fzf.enableBashIntegration = true;

  imports = [
    ./starship.nix
  ];

  programs.starship.enableBashIntegration = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;

    historyControl = [ "ignoredups" "ignorespace" ];
    historySize = 10000;
    historyFile = "$HOME/.bash_history";

    initExtra = ''
      # Case-insensitive completion
      bind 'set completion-ignore-case on'

      # Show all completions immediately
      bind 'set show-all-if-ambiguous on'
    '';
  };

  programs.kitty.settings.shell = "${pkgs.bash}/bin/bash"; # overwritten by zsh.nix
}
