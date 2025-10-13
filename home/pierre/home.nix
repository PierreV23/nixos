{ config, pkgs, lib, ... }:
{
  home.stateVersion = "25.05";

  programs.bash = {
    enable = true;
    shellAliases = {
      lla = "ll -a";
    };
  };

  # home.keyboard = { # doesnt seem to do anything, gnome seems to override this
  #   layout = "us";
  #   variant = "altgr-intl";
  # };

  imports = [
    ./applications.nix
  ];
  
  # Enable dconf for GNOME settings
  dconf.settings = {
      "org/gnome/desktop/input-sources" = {
        sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "us+altgr-intl" ]) ];
        xkb-options = [ "compose:rctrl" ];
      };

      "org/gnome/desktop/peripherals/touchpad" = {
      # Right click with corner tap instead of two-finger tap
      click-method = "areas";  # "fingers" for two-finger tap, "areas" for corner tap
      
      # Natural scrolling
      natural-scroll = true;
    };
    
    # Enable minimize and maximize buttons
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    # Theme settings
    "org/gnome/desktop/interface" = {
      gtk-theme = "Adwaita-dark";
      icon-theme = "Adwaita";
      cursor-theme = "Adwaita";
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      show-battery-percentage = true;
    };
    
    # Shell theme
    "org/gnome/shell/extensions/user-theme" = {
      name = "Adwaita-dark";
    };
    
    # Disable the default Win+V calendar shortcut
    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [];
    };
    
    # Enable extensions
    "org/gnome/shell" = {
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
      ];
      favorite-apps = [
        "firefox.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Console.desktop"
        "code.desktop"
      ];
    };
    
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
    
    # Vitals
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
        "_processor_usage_"
        "_memory_usage_"
        "_temperature_processor_0_"
      ];
      position-in-panel = 2;
    };
    
    # Blur My Shell
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      override-background = true;
      style-panel = 1;
    };
    
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      override-background = true;
      style-dash-to-dock = 1;
    };
    
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      style-components = 1;
    };
    
    # Clipboard Indicator - Win+V
    "org/gnome/shell/extensions/clipboard-indicator" = {
      toggle-menu = ["<Super>v"];
      history-size = 50;
      display-mode = 0;
    };
  };
  
  # Install packages and extensions
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
  ];
}