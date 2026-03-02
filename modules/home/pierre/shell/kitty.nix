{ ... }:
{
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
    extraConfig = ''
      linux_display_server wayland
    '';
  };

  xdg.desktopEntries.kitty = {
    name = "kitty";
    genericName = "Terminal emulator";
    exec = ''kitty -T " "'';
    icon = "kitty";
    terminal = false;
    categories = [
      "System"
      "TerminalEmulator"
    ];
  };
}
