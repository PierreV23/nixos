{ ... }:
{
  # only used for bash shells
  programs.starship = {
    enable = true;

    settings = {
      username = {
        show_always = true;
        format = "[$user]($style)@";
        style_user = "bold blue";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold dimmed white";
      };

      directory = {
        format = "[$path]($style)";
        repo_root_format = "[$before_root_path]($style) [$repo_root]($repo_root_style) [$path]($style) ";
        style = "cyan";
        repo_root_style = "bold blue";
        truncation_length = 0;
        truncate_to_repo = false;
      };

      git_branch = {
        symbol = "🌿 ";
        style = "green";
      };

      git_status = {
        format = "[$all_status]($style)";
        style = "red";
        conflicted = "🚨";
        modified = "!";
        untracked = "?";
      };

      format = ''
        $username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character
      '';

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
    };
  };
}
