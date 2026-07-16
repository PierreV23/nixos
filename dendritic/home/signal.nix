{ ... }:
{
  flake.modules.homeManager.signal = { pkgs, ... }: {
    xdg.desktopEntries.signal-desktop = {
      name = "Signal";
      genericName = "Messaging Application";
      exec = "env GTK_THEME=Adwaita:dark ${pkgs.signal-desktop}/bin/signal-desktop";
      icon = "${pkgs.signal-desktop}/share/icons/hicolor/512x512/apps/signal-desktop.png";
      terminal = false;
      categories = [ "Network" "InstantMessaging" ];
      startupNotify = true;
    };
  };
}