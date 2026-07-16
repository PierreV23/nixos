{ ... }:
{
  flake.modules.homeManager.packages =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        # libreoffice stable
        libreoffice-still

        # moonlight client to connect to soonshine server (HQ screenshare)
        moonlight-qt

        # wayland clipboard
        wl-clipboard
      ];
    };
}
