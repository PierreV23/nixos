{
  flake.modules.homeManager.gnome =
    { pkgs, lib, ... }:
    {
      dconf.settings = {
        "org/gnome/desktop/input-sources" = {
          sources = [
            (lib.hm.gvariant.mkTuple [
              "xkb"
              "us+altgr-intl"
            ])
          ];
          xkb-options = [ "compose:rctrl" ];
        };

        "org/gnome/desktop/peripherals/touchpad" = {
          click-method = "areas";
          natural-scroll = true;
        };

        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };

        "org/gnome/desktop/interface" = {
          gtk-theme = "Adwaita-dark";
          icon-theme = "Adwaita";
          cursor-theme = "Adwaita";
          color-scheme = "prefer-dark";
          clock-show-weekday = true;
          show-battery-percentage = true;
        };

        "org/gnome/shell/keybindings" = {
          toggle-message-tray = [ ];
        };

        "org/gnome/shell" = {
          always-show-log-out = true;
          disable-user-extensions = false;
          enabled-extensions = [
            "dash-to-dock@micxgx.gmail.com"
            "Vitals@CoreCoding.com"
            "blur-my-shell@aunetx"
            "clipboard-indicator@tudmotu.com"
            "weatherornot@somepaulo.github.io"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "gsconnect@andyholmes.github.io"
            "appindicatorsupport@rgcjonas.gmail.com"
            "tilingshell@ferrarodomenico.com"
          ];
          favorite-apps = [
            "firefox.desktop"
            "org.gnome.Nautilus.desktop"
            "kitty.desktop"
            "code.desktop"
          ];
        };

        # lower dock
        "org/gnome/shell/extensions/dash-to-dock" = {
          dock-position = "BOTTOM";
          dock-fixed = false;
          autohide = true;
          intellihide = true;
          autohide-in-fullscreen = true;
          dash-max-icon-size = 48;
          show-trash = false;
          show-mounts = false;
          extend-height = false;
          transparency-mode = "FIXED";
          background-opacity = 0.2;
          require-pressure-to-show = true;
          customize-alphas = true;
          min-alpha = 0.2;
          max-alpha = 0.2;
        };

        # vitals
        "org/gnome/shell/extensions/vitals" = {
          hot-sensors = [
            "_processor_usage_"
            "_memory_usage_"
            "_temperature_processor_0_"
          ];
          position-in-panel = 2;
        };

        # "org/gnome/shell/extensions/blur-my-shell/panel" = {
        #   blur = true;
        #   override-background = true;
        #   style-panel = 1;
        # };

        # "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
        #   blur = true;
        #   override-background = true;
        #   style-dash-to-dock = 1;
        # };

        # "org/gnome/shell/extensions/blur-my-shell/overview" = {
        #   blur = true;
        #   style-components = 1;
        # };

        # clipboard
        "org/gnome/shell/extensions/clipboard-indicator" = {
          toggle-menu = [ "<Super>v" ];
          history-size = 50;
          display-mode = 0;
        };

        # tilingshell shortcuts
        "org/gnome/shell/extensions/tilingshell" = {
          # layouts
          layouts-json = ''[{"id":"thirds-split","tiles":[{"x":0,"y":0,"width":0.3334302325581395,"height":0.5,"groups":[1,3]},{"x":0.3334302325581395,"y":0,"width":0.33313953488372094,"height":1,"groups":[2,1]},{"x":0.6665697674418605,"y":0,"width":0.3334302325581392,"height":0.5,"groups":[4,2]},{"x":0,"y":0.5,"width":0.3334302325581395,"height":0.5,"groups":[3,1]},{"x":0.6665697674418605,"y":0.5,"width":0.3334302325581392,"height":0.5,"groups":[4,2]}]},{"id":"quarters","tiles":[{"x":0.5,"y":0,"width":0.25,"height":1,"groups":[3,1]},{"x":0,"y":0,"width":0.25,"height":0.5,"groups":[2,5]},{"x":0.25,"y":0,"width":0.25000000000000044,"height":1,"groups":[1,2]},{"x":0.75,"y":0,"width":0.25,"height":0.5,"groups":[4,3]},{"x":0.75,"y":0.5,"width":0.25,"height":0.5,"groups":[4,3]},{"x":0,"y":0.5,"width":0.25,"height":0.5,"groups":[5,2]}]}]'';
          selected-layouts = [ [ "thirds-split" ] [ "thirds-split" ] ];

          # keybindings
          span-window-up = [ "<Super><Control>Up" ];
          span-window-down = [ "<Super><Control>Down" ];
          span-window-left = [ "<Super><Control>Left" ];
          span-window-right = [ "<Super><Control>Right" ];
          span-window-all-tiles = [ "<Super><Control>Return" ];
          untile-window = [ "<Super>BackSpace" ];
          cycle-layouts = [ "<Super><Control>period" ];
          cycle-layouts-backward = [ "<Super><Control>comma" ];
        };
      };

      home.packages = with pkgs; [
        gnome-tweaks
        gnome-shell-extensions
        gnome-weather
        geoclue2
        gnomeExtensions.dash-to-dock
        gnomeExtensions.vitals
        gnomeExtensions.blur-my-shell
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.weather-or-not
        gnomeExtensions.gsconnect
        gnomeExtensions.appindicator
        gnomeExtensions.tiling-shell
      ];
    };
}