{ config, inputs, lib, ... }:
let
  flakeCfg  = config.flake;
  secrets   = import ../../vars/secrets.nix { inherit lib; };
  assh      = import ../_lib/assh.nix { inherit lib; };
  asshHosts = import ../_lib/assh-hosts.nix { inherit secrets; };
in
{
  flake.nixosConfigurations.e14g7 = inputs.nixpkgs-2605.lib.nixosSystem {
    modules = [
      # base host configs
      ../../hosts/e14g7/configuration.nix
      ../../hosts/e14g7/hardware-configuration.nix
      inputs.sops-nix.nixosModules.sops

      # pierre user as dendritic
      flakeCfg.modules.nixos.pierre
      flakeCfg.modules.nixos.overlays
      flakeCfg.modules.nixos.nix_ld
      flakeCfg.modules.nixos.virtualisation
      flakeCfg.modules.nixos.geoclue
      flakeCfg.modules.nixos.sudo
      flakeCfg.modules.nixos.disable-default-apps
      flakeCfg.modules.nixos.cl_packages
      flakeCfg.modules.nixos.nix_packages
      flakeCfg.modules.nixos.auto-cleanup


      inputs.home-manager-2605.nixosModules.home-manager
      {
        sops.defaultSopsFile = ../../secrets/secrets.yaml;
        sops.age.keyFile = "/var/lib/sops-nix/key.txt";
        sops.secrets.id_e14g7_pierre = {
          owner = "pierre";
          group = "users";
          mode = "0400";
        };

        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bak";
        home-manager.users.pierre.imports = [
          {
            home.stateVersion = lib.mkForce "26.05";
          }
          flakeCfg.modules.homeManager.pierre
          flakeCfg.modules.homeManager.git
          flakeCfg.modules.homeManager.firefox
          flakeCfg.modules.homeManager.vscode
          flakeCfg.modules.homeManager.prismlauncher
          flakeCfg.modules.homeManager.gnome
          flakeCfg.modules.homeManager.packages # general apps
          flakeCfg.modules.homeManager.vm
          flakeCfg.modules.homeManager.flatpak # general apps via flatpak
          flakeCfg.modules.homeManager.cl_packages # general cli
          flakeCfg.modules.homeManager.nix_packages
          flakeCfg.modules.homeManager.direnv
          flakeCfg.modules.homeManager.signal
          flakeCfg.modules.homeManager.zapzap
          flakeCfg.modules.homeManager.autoupdate-unstable

          ({ pkgs, ... }: {
            home.packages = [ pkgs.age pkgs.sops ];
          })

          (assh.homeModule {
            keys = { osConfig, ... }: {
              id_e14g7_pierre = osConfig.sops.secrets.id_e14g7_pierre.path;
              id_t480s_pierre = assh.secret secrets.ssh.t480s.private_key;
            };
            yaml = { pkgs, keys }: assh.mkYaml {
              defaults = ''
                ASSHBinaryPath: ${pkgs.assh}/bin/assh
                ControlPath: ~/.ssh/sockets/%C
                IdentityFile: ${keys.id_e14g7_pierre}
              '';
              hosts = [ asshHosts.personal ];
            };
          })
        ];
      }
    ];
  };
}