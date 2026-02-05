{ ... }:
{
  imports = [
    ./zsh # zsh will take precedence over bash (not due to order, i just tell zsh to force itself)
    ./bash.nix
  ];

  # Kinda like 'cat' but with code/config highlighting
  programs.bat.enable = true;

  # Fuzzy finder. Used for viewing history (ctrl+r) and searching files (ctrl+t) inside terminal.
  programs.fzf = {
    enable = true;
    defaultOptions = [ "--height 40%" "--border" ];
    fileWidgetOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}'" ]; # Preview files with 'bat'
  };

  home.shellAliases = {
    lla = "ls -la";
    latr = "ls -latr";
    please = "sudo !!";
  };

  programs.kitty = {
    enable = true;
    themeFile = "tokyo_night_night";
    settings = {
      background_opacity = "0.85";
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      update_check_interval = 0;
      window_padding_width = 8;
    };
  };
}
