{ ... }:
{
  flake.modules.nixos.auto-cleanup = {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    nix.optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };
}
