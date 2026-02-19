{ pkgs, ... }:
{
  # Enable KVM for best virtualization performance
  virtualisation = {
    docker = {
      enable = true;
    };
    # Enable libvirtd with full KVM support
    libvirtd = {
      enable = true;

      # package = pkgs.qemu_kvm.override {
      #             virtiofsdSupport = true;
      #         };

      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        ovmf.enable = true;
        # ovmf.packages = [ pkgs.OVMF.fd ];
        ovmf.packages = [ pkgs.OVMFFull.fd ]; # i still have no clue why this is needed 👍
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
  };

  # systemd.services.libvirtd = {
  #     path = [ pkgs.virtiofsd pkgs.swtpm ];
  #     serviceConfig = {
  #         Environment = "PATH=${pkgs.virtiofsd}/bin:${pkgs.swtpm}/bin:$PATH";
  #     };
  # };

  systemd.tmpfiles.rules = [
    "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware"
  ];

  environment.systemPackages = with pkgs; [
    # Below are likely unneeded (the commented things)? already defined in `virtualisation.libvirtd.qemu...` above
    #
    # qemu_kvm # the one behind it all (kenjaku)
    # swtpm # software tpm, required for windows vm
    # virtiofsd # shared fs
    # (qemu_kvm.override {
    #     extraPackages = [ virtiofsd ];
    # }) # this would throw an error
    # qemu # the second behind it all (??, idk kenjaku 2)

    # Required on system
    win-virtio # to support copy/pasting to and from VMs (guest machine requires virtio drivers)

  ];
}
