{ pkgs, secrets, ... }:
{
  users.users.services = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "docker"
    ];
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
      secrets.ssh.r7game-wsl.nixos.public_key
      secrest.ssh.t480s.public_key
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    secrets.ssh.r7game.public_key
    secrets.ssh.r7game-wsl.nixos.public_key
    secrest.ssh.t480s.public_key
  ];
}
