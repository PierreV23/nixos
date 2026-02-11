{...}:
{
  # this is required if a user wants widgets to use geoclue

  services.geoclue2 = {
      enable = true;
      enableDemoAgent = false;
      geoProviderUrl = "https://location.services.mozilla.com/v1/geolocate?key=geoclue";

      # Allow GNOME Weather and Shell to use location
      appConfig = {
          "gnome-weather" = {
              isAllowed = true;
              isSystem = false;
          };
          "org.gnome.Shell" = {
              isAllowed = true;
              isSystem = true;
          };
      };
  };
}
