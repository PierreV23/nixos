{...}:
{
    flake.modules.nixos.printing =
    {pkgs, ...}:
        {
        services.printing = {
            enable = true;
            browsed.enable = false;
        };

        services.avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };

        hardware.sane = {
            enable = true;
            extraBackends = [ pkgs.sane-airscan ];
        };
    };
}