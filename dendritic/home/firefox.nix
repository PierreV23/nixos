{
  flake.modules.homeManager.firefox = { pkgs, ... }: {
    programs.firefox = {
      enable = true;
      package = pkgs.unstable.firefox;

      profiles.default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions.packages = with pkgs.firefox-addons; [
          ublock-origin
          sponsorblock
          proton-vpn
          proton-pass
          multi-account-containers
        ];

        settings = {
          "extensions.autoDisableScopes" = 0;
          "extensions.enabledScopes" = 15;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "sidebar.verticalTabs" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
          "browser.startup.page" = 3; # restore previous session
          "extensions.formautofill.creditCards.enabled" = false;
          "signon.rememberSignons" = false; # dont ask to save my password
          "signon.autofillForms" = false; # dont autofill my password
          "signon.generation.enabled" = false; # dont reccomend strong passwords
        };
      };
    };
  };
}
