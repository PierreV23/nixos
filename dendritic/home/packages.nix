{ ... }:
{
  flake.modules.homeManager.packages = { pkgs, ... }: {
    home.packages = with pkgs; [
      libreoffice-still
      moonlight-qt
      wl-clipboard
    ];
  };
}