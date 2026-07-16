{ ... }:
{
  flake.modules.nixos.virtualisation = { pkgs, ... }: {
    virtualisation = {
      docker.enable = true;
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
      };
    };

    systemd.tmpfiles.rules = [
      "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
    ];

    environment.systemPackages = [ pkgs.virtio-win ]; # clipboard + guest drivers
  };
}