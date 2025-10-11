{ config, pkgs, lib, ... }:
let
in
{
    programs.firefox = {
        enable = true;
        
        profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;
            
            extensions.packages = with pkgs.firefox-addons; [
                ublock-origin
                sponsorblock
                proton-vpn
                proton-pass
            ];

            settings = {
                "extensions.autoDisableScopes" = 0;
                "extensions.enabledScopes" = 15;
                "extensions.htmlaboutaddons.recommendations.enabled" = false;
            };
        };
    };
}