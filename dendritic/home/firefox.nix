{
  flake.modules.homeManager.firefox =
    { pkgs, ... }:
    {
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
            single-file
            consent-o-matic
          ];

          # Container icons: fingerprint, briefcase, dollar, cart, circle, gift, vacation, food, fruit, pet, tree, chill, fence
          # Container colors: blue, turquoise, green, yellow, orange, red, pink, purple, toolbar
          containers = {
            Personal = {
              id = 1;
              icon = "fingerprint";
              color = "blue";
            };
            Work = {
              id = 2;
              icon = "briefcase";
              color = "orange";
            };
          };
          containersForce = true;

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

            # keep the downloads button visible always
            "browser.download.autohideButton" = false;

            # toolbar layout
            "browser.uiCustomization.state" = builtins.toJSON {
              placements = {
                widget-overflow-fixed-list = [ ];
                unified-extensions-area = [
                  "sponsorblocker_ajay_app-browser-action"
                  "vpn_proton_ch-browser-action"
                  "gdpr_cavi_au_dk-browser-action"
                  "_4f391a9e-8717-4ba6-a5b1-488a34931fcb_-browser-action"
                  "_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action"
                ];
                nav-bar = [
                  "sidebar-button"
                  "firefox-view-button"
                  "alltabs-button"
                  "_testpilot-containers-browser-action"
                  "back-button"
                  "forward-button"
                  "stop-reload-button"
                  "urlbar-container"
                  "ublock0_raymondhill_net-browser-action"
                  "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
                  "unified-extensions-button"
                  "downloads-button"
                  "reset-pbm-toolbar-button"
                ];
                toolbar-menubar = [ "menubar-items" ];
                TabsToolbar = [ ];
                vertical-tabs = [ "tabbrowser-tabs" ];
                PersonalToolbar = [
                  "import-button"
                  "personal-bookmarks"
                ];
              };
              seen = [
                "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
                "vpn_proton_ch-browser-action"
                "_testpilot-containers-browser-action"
                "ublock0_raymondhill_net-browser-action"
                "sponsorblocker_ajay_app-browser-action"
                "developer-button"
                "screenshot-button"
                "reset-pbm-toolbar-button"
                "gdpr_cavi_au_dk-browser-action"
                "_4f391a9e-8717-4ba6-a5b1-488a34931fcb_-browser-action"
                "_531906d3-e22f-4a6c-a102-8057b88a1a63_-browser-action"
              ];
              dirtyAreaCache = [
                "unified-extensions-area"
                "nav-bar"
                "TabsToolbar"
                "vertical-tabs"
                "PersonalToolbar"
                "toolbar-menubar"
              ];
              currentVersion = 24;
              newElementCount = 0;
            };
          };
        };
      };
    };
}