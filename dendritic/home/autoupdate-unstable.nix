{
  flake.modules.homeManager.autoupdate-unstable =
    { lib, pkgs, ... }:
    let
      flakeDir = "/etc/nixos";
      input = "nixpkgs-unstable";

      updater = pkgs.writeShellApplication {
        name = "nixpkgs-unstable-autoupdate";
        runtimeInputs = with pkgs; [ git nix jq libnotify coreutils ];
        text = ''
          set -euo pipefail
          cd ${flakeDir}

          log="/tmp/nixos-autorebuild.log"

          # dont touch a dirty tree
          if [ -n "$(git status --porcelain)" ]; then
            notify-send --app-name="NixOS" -u low \
              "${input}" "Skipped: working tree is dirty." || true
            exit 0
          fi

          oldDate=$(date -u -d "@$(jq -r '.nodes."${input}".locked.lastModified' flake.lock)" +%F)

          # update just this input
          nix flake update ${input}

          # checking if upstream unchanged for whatever reason (maybe i'll reuse for a slow input, or maybe i already updated manually)
          if git diff --quiet -- flake.lock; then
            exit 0
          fi

          newDate=$(date -u -d "@$(jq -r '.nodes."${input}".locked.lastModified' flake.lock)" +%F)

          # commit the lockfile
          git add flake.lock
          git commit -m "Update ${input} from ''${oldDate} to ''${newDate}"

          # ask with a interactive GNOME notif whether to rebuild or not
          action=$(notify-send \
            --app-name="NixOS" \
            --urgency=normal \
            --expire-time=0 \
            --action="rebuild=Rebuild now" \
            --action="later=Later" \
            --wait \
            "${input} updated" \
            "''${oldDate} → ''${newDate}. Run nixos-rebuild switch now?" || true)

          # if rebuilding: GNOME's polkit agent prompts for user password,
          #    build runs detached, result comes back as a notification
          if [ "$action" = "rebuild" ]; then
            if /run/wrappers/bin/pkexec ${pkgs.bash}/bin/bash -lc 'nixos-rebuild switch' >"$log" 2>&1; then
              notify-send --app-name="NixOS" \
                "Rebuild complete" "nixos-rebuild switch succeeded."
            else
              notify-send --app-name="NixOS" -u critical \
                "Rebuild failed" "See $log  (or: journalctl -b -e)"
            fi
          fi
        '';
      };
    in
    {
      systemd.user.services.nixpkgs-unstable-autoupdate = {
        Unit = {
          Description = "Update the ${input} flake input and offer to rebuild";
          After = [ "graphical-session.target" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = lib.getExe updater;
        };
      };

      systemd.user.timers.nixpkgs-unstable-autoupdate = {
        Unit.Description = "Weekly ${input} update";
        Timer = {
          OnCalendar = "Mon *-*-* 10:00:00";
          Persistent = true; # if missed, try again next login
          RandomizedDelaySec = "1h";
        };
        Install.WantedBy = [ "timers.target" ];
      };
    };
}