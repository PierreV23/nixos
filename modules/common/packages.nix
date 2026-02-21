# packages.nix
{ pkgs }: with pkgs; {
  common = [
    git
    git-crypt
  ];
  
  nix = [
    home-manager
    nixfmt-rfc-style
  ];
}