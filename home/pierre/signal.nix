{ pkgs, ... }:
{
  xdg.desktopEntries.signal-desktop = {
    name = "Signal";
    genericName = "Messaging Application";
    exec = "env GTK_THEME=Adwaita:dark ${pkgs.signal-desktop}/bin/signal-desktop";
    icon = "signal-desktop";
    terminal = false;
    categories = [ "Network" "InstantMessaging" ];
    startupNotify = true;
  };
}
