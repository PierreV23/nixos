{ inputs, ... }:
{
  flake.modules.homeManager.flatpak =
    { ... }:
    {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

      services.flatpak = {
        update.auto.enable = false;
        uninstallUnmanaged = false;
        enable = true;
        packages = [
          "com.discordapp.Discord"
        ];
      };
    };
}
