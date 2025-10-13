{
    imports = [
        ./starship.nix
    ];

    programs.bash = {
        enable = true;
            shellAliases = {
            lla = "ll -a";
        };
    };
}