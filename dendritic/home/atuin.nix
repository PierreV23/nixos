{
  flake.modules.homeManager.atuin =
    { lib, ... }:
    {
      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        flags = [
          "--disable-ctrl-r"
          "--disable-up-arrow"
        ];
        settings = {
          auto_sync = false;
          update_check = false;
          filter_mode = "global";
          style = "compact";
          inline_height = 20;
          enter_accept = false;
        };
      };

      programs.zsh.initContent = lib.mkAfter ''
        bindkey '^[r' atuin-search   # Alt+R
      '';
    };
}