{
    imports = [
        ./applications/vscode/vscode.nix
        ./applications/firefox/firefox.nix
    ];

    services.flatpak = {
        update.auto.enable = false;
        uninstallUnmanaged = false;
        enable = true;
        packages = [
            "com.modrinth.ModrinthApp"
            "com.discordapp.Discord"
        ];
    };
}
