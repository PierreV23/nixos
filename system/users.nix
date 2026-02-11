{pkgs, ...}:
{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pierre = {
    isNormalUser = true;
    description = "Pierre";
    shell = pkgs.zsh; # zsh as default shell
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "qemu-libvirtd"
      "docker"
    ];
    packages = []; # pkgs.<>
  };
}
