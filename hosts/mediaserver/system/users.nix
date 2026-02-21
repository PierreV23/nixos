{ pkgs, secrets, ... }:
{
  users.users.services = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
    ];
    openssh.authorizedKeys.keys = [
      secrets.ssh.r7game.public_key
    ];
  };

  users.users.root.openssh.authorizedKeys.keys = [
    secrets.ssh.r7game.public_key
  ];
}
