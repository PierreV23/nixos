{
  flake.modules.homeManager.kitty =
    { lib, ... }:
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
          linux_display_server = lib.mkDefault "wayland";
        };
        keybindings = {
          "ctrl+shift+delete" = "combine : clear_terminal scrollback active : send_text normal,application \\x0c";
          "ctrl+shift+alt+c" = "launch --stdin-source=@screen_scrollback --type=clipboard";
        };
        extraConfig = ''
          allow_remote_control yes
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
    };
}
