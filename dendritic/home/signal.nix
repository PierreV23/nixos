{ ... }:
{
  flake.modules.homeManager.signal = { pkgs, ... }: {
    home.packages = [
      (pkgs.symlinkJoin {
        name = "signal-desktop-themed";
        paths = [ pkgs.unstable.signal-desktop ];
        nativeBuildInputs = [ pkgs.makeWrapper ];
        postBuild = ''
          wrapProgram $out/bin/signal-desktop \
            --set GTK_THEME "Adwaita:dark"

          for f in $out/share/applications/*.desktop; do
            src=$(readlink -f "$f")
            rm "$f"
            sed "s|${pkgs.unstable.signal-desktop}/bin/signal-desktop|$out/bin/signal-desktop|g" "$src" > "$f"
          done
        '';
      })
    ];
  };
}