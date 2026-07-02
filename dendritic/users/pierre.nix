let
  userName = "pierre";
in
{
  # system account
  flake.modules.nixos.${userName} = {
    users.users.${userName} = {
      isNormalUser = true;
      description = "pierre";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };

  # home-manager environment
  flake.modules.homeManager.${userName} = { lib, ... }: {
    home.username = userName;
    home.homeDirectory = lib.mkDefault "/home/${userName}";
    home.stateVersion = lib.mkDefault "26.05";
  };
}
