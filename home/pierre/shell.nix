{
    imports = [
        ./starship.nix
    ];


    # Kinda like 'cat' but with code/config highlighting
    programs.bat.enable = true;

    # Fuzzy finder. Used for viewing history (ctrl+r) and searching files (ctrl+t) inside terminal.
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;

      defaultOptions = [
        "--height 40%"
        "--border"
      ];

      fileWidgetOptions = [
        # Preview files with 'bat'
        "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
      ];
    };

    programs.bash = {
      enable = true;
      # Bash aliases
      shellAliases = {
        lla = "ll -a";
        please = "sudo !!";
      };
    };
}
