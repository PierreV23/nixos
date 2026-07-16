{ ... }:
{
  flake.modules.homeManager.zapzap = { pkgs, ... }: {
    home.packages = [
        pkgs.unstable.zapzap
    ];
  };
}
