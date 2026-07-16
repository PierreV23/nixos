{ ... }:
{
  #@ TODO: honestly not sure if all of this is actually needed but i ported it anyway
  flake.modules.nixos.geoclue = { ... }: {
    services.geoclue2 = {
      enable = true;
      enableDemoAgent = false;
      geoProviderUrl = "https://api.beacondb.net/v1/geolocate";
      appConfig = {
        "gnome-weather" = { isAllowed = true; isSystem = false; };
        "org.gnome.Shell" = { isAllowed = true; isSystem = true; };
      };
    };

    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}