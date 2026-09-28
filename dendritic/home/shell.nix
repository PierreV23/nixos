{
  flake.modules.homeManager.shell =
    { pkgs, ... }:
    {
      # Kinda like 'cat' but with code/config highlighting
      programs.bat.enable = true;

      # Fuzzy finder. Used for viewing history (ctrl+r) and searching files (ctrl+t) inside terminal.
      programs.fzf = {
        enable = true;
        defaultOptions = [
          "--height 40%"
          "--border"
        ];
        fileWidgetOptions = [ "--preview 'bat --color=always --style=numbers --line-range=:500 {}'" ]; # Preview files with 'bat'
      };

      home.shellAliases = {
        lla = "ls -la";
        latr = "ls -latr";
        please = "sudo !!";
        ".." = "cd ..";
        "..." = "cd ../..";
        grep = "grep --color=auto";
        diff = "diff --color=auto";
        hmrb = "home-manager switch --flake /etc/nixos/hosts/t480s/home/pierre#pierre";
        norb = "sudo nixos-rebuild switch";
      };

      home.packages = [
        # insane alias coding 😎
        (pkgs.writeShellScriptBin "cbc" ''
          ${pkgs.ansifilter}/bin/ansifilter | ${pkgs.wl-clipboard}/bin/wl-copy "$@" --type text/plain
        '')
        (pkgs.writeShellScriptBin "cbp" "${pkgs.wl-clipboard}/bin/wl-paste \"$@\"")
      ];
    };
}
