{ config, inputs, lib, ... }:
let
  secrets = import ../../vars/secrets.nix { inherit lib; };
  assh    = import ../_lib/assh.nix { inherit lib; };
in
{
  flake.nixosConfigurations.e14g7 = inputs.nixpkgs-2605.lib.nixosSystem {
    modules = [
      # base host configs
      ../../hosts/e14g7/configuration.nix
      ../../hosts/e14g7/hardware-configuration.nix

      # pierre user as dendritic
      config.flake.modules.nixos.pierre
      config.flake.modules.nixos.overlays

      inputs.home-manager-2605.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-bak"; # overwrites already existing (config) files
        home-manager.users.pierre.imports = [
          config.flake.modules.homeManager.pierre
          config.flake.modules.homeManager.git
          config.flake.modules.homeManager.firefox
          config.flake.modules.homeManager.vscode
          config.flake.modules.homeManager.prismlauncher
          (assh.homeModule {
            keys.id_e14g7_pierre = secrets.ssh.e14g7.private_key;
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
                  Gateways:
                    - direct
                    - wg-mediaserver
                
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
