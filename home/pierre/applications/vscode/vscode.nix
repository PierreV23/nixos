{ config, pkgs, lib, ... }:

let
    extensionsList = lib.splitString "\n" (builtins.readFile ./vscode-extensions.txt);
    
    extensions = map (ext: lib.getAttrFromPath (lib.splitString "." ext) pkgs.vscode-marketplace) 
        (lib.filter (ext: ext != "") extensionsList);
in
{
    programs.vscode = {
        enable = true;
        inherit extensions;
        
        userSettings = builtins.fromJSON (builtins.readFile ./vscode-settings.json);
    };
}