{ ... }:
{
  imports = [
    ./ssh.nix
    ./programs.nix
    ./users.nix
    ./vpn.nix
    ./virtualization.nix
  ];
}
