{pkgs, ...}:
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
            "app.zen_browser.zen"
        ];
    };

    home.packages = with pkgs; [
        zapzap # whatsapp
        typst
        tinymist # typst language server
        nixd # nix language server
    ];

    programs.zed-editor = {
        enable = true;
        extensions = [
            "nix"
            "rust"
        ];
    };
}
