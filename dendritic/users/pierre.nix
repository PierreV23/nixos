let
  userName = "pierre";
in
{
  # system account
  flake.modules.nixos.${userName} =
    { pkgs, ... }:
    {
      programs.zsh.enable = true;

      users.users.${userName} = {
        isNormalUser = true;
        description = "pierre";
        extraGroups = [
          "networkmanager"
          "wheel"
          "libvirtd"
          "qemu-libvirtd"
          "docker"
        ];
      };
    };

  # home-manager environment
  flake.modules.homeManager.${userName} =
    { lib, ... }:
    {
      home.username = userName;
      home.homeDirectory = lib.mkDefault "/home/${userName}";
      home.stateVersion = lib.mkDefault "26.05";
    };
}
