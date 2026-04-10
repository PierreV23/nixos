{ repoRoot, pkgs, ... }:
let
  packages = import "${repoRoot}/modules/common/packages.nix" { inherit pkgs; };
in
{
  environment.systemPackages = packages.common ++ packages.nix;

  programs.direnv.enable = true;
}
