{ lib, pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "gnome";

  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;

  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;

  # Use gnome ssh ask password or something lik that
  programs.ssh.askPassword = lib.mkForce "${lib.getBin pkgs.seahorse}/libexec/seahorse/ssh-askpass";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "altgr-intl"; # not sure if this does anything
  };

  # Configure console keymap
  console.keyMap = "us";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
