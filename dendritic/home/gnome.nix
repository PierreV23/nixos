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

        "org/gnome/settings-daemon/plugins/media-keys" = {
          custom-keybindings = [
            "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/smile/"
          ];
        };
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/smile" = {
          name = "Smile";
          command = "smile";
          binding = "<Super>period";
        };

        # app grid folders
        "org/gnome/desktop/app-folders" = {
          folder-children = [
            "Code"
            "Chat"
            "Office"
            "GNOME"
            "Utilities"
            "System"
            "VM"
            "Games"
            "Extra"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Code" = {
          name = "Code";
          apps = [
            "code.desktop"
            "org.gnome.Console.desktop"
            "kitty.desktop"
            "htop.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Chat" = {
          name = "Chat";
          apps = [
            "com.discordapp.Discord.desktop"
            "com.rtosta.zapzap.desktop"
            "signal.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Office" = {
          name = "Office";
          apps = [
            "startcenter.desktop"
            "writer.desktop"
            "calc.desktop"
            "impress.desktop"
            "draw.desktop"
            "base.desktop"
            "math.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/GNOME" = {
          name = "GNOME";
          apps = [
            "org.gnome.TextEditor.desktop"
            "org.gnome.Weather.desktop"
            "org.gnome.Calendar.desktop"
            "org.gnome.Snapshot.desktop"
            "org.gnome.Software.desktop"
            "org.gnome.ColorProfileViewer.desktop"
            "org.gnome.Nautilus.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Utilities" = {
          name = "Utilities";
          apps = [
            "org.gnome.Papers.desktop"
            "org.gnome.Loupe.desktop"
            "org.gnome.font-viewer.desktop"
            "org.gnome.Calculator.desktop"
            "org.gnome.clocks.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/System" = {
          name = "System";
          apps = [
            "org.gnome.baobab.desktop"
            "org.gnome.DiskUtility.desktop"
            "org.gnome.Logs.desktop"
            "org.gnome.SystemMonitor.desktop"
            "org.gnome.Settings.desktop"
            "org.gnome.Extensions.desktop"
            "org.gnome.tweaks.desktop"
            "cups.desktop"
            "org.gnome.seahorse.Application.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/VM" = {
          name = "VM";
          apps = [
            "virt-manager.desktop"
            "remote-viewer.desktop"
            "com.moonlight_stream.Moonlight.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Games" = {
          name = "Games";
          apps = [
            "org.prismlauncher.PrismLauncher.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Extra" = {
          name = "Extra";
          apps = [
            "it.mijorus.smile.desktop"
          ];
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
            "smile-extension@mijorus.it"
            "pinned-apps-in-appgrid@brunosilva.io"
          ];
          favorite-apps = [
            "firefox.desktop"
            "org.gnome.Nautilus.desktop"
            "kitty.desktop"
            "code.desktop"
          ];
        };
      };

      home.packages = with pkgs; [
        gnome-tweaks
        gnome-themes-extra
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
        gnomeExtensions.keep-pinned-apps-in-appgrid

        # wayland emoji selector with shortcut
        smile
        gnomeExtensions.smile-complementary-extension
      ];
    };
}