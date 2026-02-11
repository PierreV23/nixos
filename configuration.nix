# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix

        # system config
        ./system
        ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

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
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;

        # use the example session manager (no others are packaged yet so this is enabled by default,
        # no need to redefine it in your config for now)
        #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    programs.zsh.enable = true;
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.pierre = {
        isNormalUser = true;
        description = "Pierre";
        shell = pkgs.zsh;  # Add this line
        extraGroups = [ "networkmanager" "wheel" "libvirtd" "qemu-libvirtd" "docker"];
        packages = with pkgs; [
        #  thunderbird
        ];
    };

    # Install firefox.
    # programs.firefox.enable = true;

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
        git

        wireguard-tools

        # home manager cli
        home-manager
    ];

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc # c(pp) compiler libraries

        # fetching (bark)
        curl
        wget

        openssl # ssl

        libssh # ssh

        libxml2 # xml parser

        # file stuff
        attr
        acl # acces control list (idk why i need this tbh)

        util-linux # core utils or smht

        # compression libraries
        bzip2
        libsodium
        xz
        zlib
        zstd

        systemd # idk if this is needed here but im too scared to delete it :eyes:

        networkmanagerapplet # network manager app

        quickemu # easy way to manage vms but iirc its kinda trash so i'll delete it (TODO)

        qemu # the second behind it all (??, idk kenjaku 2)
      ];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?


    # Bandaid patch to stop NixOS from listening to 'wake on lan' packets via ethernet, even tho it was already disabled in BIOS
    systemd.services.disable-wol = {
      description = "Disable Wake-on-LAN";
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.ethtool}/bin/ethtool -s enp0s31f6 wol d";
      };
    };
}
