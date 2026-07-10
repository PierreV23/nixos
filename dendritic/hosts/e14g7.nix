{ config, inputs, lib, ... }:
let
  flakeCfg = config.flake;
  secrets  = import ../../vars/secrets.nix { inherit lib; };
  assh     = import ../_lib/assh.nix { inherit lib; };
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
          flakeCfg.modules.homeManager.pierre
          flakeCfg.modules.homeManager.git
          flakeCfg.modules.homeManager.firefox
          flakeCfg.modules.homeManager.vscode
          flakeCfg.modules.homeManager.prismlauncher

          ({ pkgs, ... }: {
            home.packages = [ pkgs.age pkgs.sops ];
          })

          (assh.homeModule {
            keys = { osConfig, ... }: {
              id_e14g7_pierre = osConfig.sops.secrets.id_e14g7_pierre.path;
              id_t480s_pierre = assh.secret secrets.ssh.t480s.private_key;
            };
            yaml = { pkgs, keys }: ''
              defaults:
                ASSHBinaryPath: ${pkgs.assh}/bin/assh
                ControlPath: ~/.ssh/sockets/%C
                IdentityFile: ${keys.id_e14g7_pierre}

              hosts:
                eth:
                  Hostname: ${secrets.eth.ip}
                  User: root
                wg-mediaserver:
                  Hostname: ${secrets.mediaserver.wg.local_ip}
                  User: root
                  Gateways: [ direct, eth ]
                nova:
                  Hostname: ${secrets.nova.ip}
                  User: root
                hostbrr:
                  Hostname: ftpus1.hostypanel.com
                  User: s1brbrst
                  Port: 53211
                mediaserver:
                  Hostname: ${secrets.mediaserver.ip_local}
                  User: root
                  Gateways: [ direct, wg-mediaserver ]
                r5homeserver:
                  Hostname: 192.168.1.15
                  User: pierre
                  Gateways: [ direct, wg-mediaserver ]
                github.com:
                  Hostname: github.com
                  User: git
            '';
          })
        ];
      }
    ];
  };
}