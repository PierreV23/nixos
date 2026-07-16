{ ... }:
{
  flake.modules.homeManager.vm =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        libvirt
        virt-manager
        virt-viewer
      ];
    };
}
