{ ... }:
{
  # Flatpak is a quite popular 'appstore'. Flatpak has both official and 3rd party repacked apps
  services.flatpak = {
    update.auto.enable = false;
    uninstallUnmanaged = false;
    enable = true;
    packages = [
      "com.modrinth.ModrinthApp" # Minecraft mod(pack) manager
      "com.discordapp.Discord" # Chat app
      "app.zen_browser.zen" # Browser based off firefox
    ];
  };
}
