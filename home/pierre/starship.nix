{
    programs.starship = {
        enable = true;
        enableBashIntegration = true;
        settings = {
            # Restore username and hostname
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
            
            # Restore full current working directory
            directory = {
                format = "[$path]($style)";
                
                repo_root_format = ''[$before_root_path]($style) [$repo_root]($repo_root_style) [$path]($style) '';
                
                style = "cyan";
                repo_root_style = "bold blue";
                
                truncation_length = 0;
                truncate_to_repo = false;
            };
            
            # Customize git branch and status
            git_branch = {
                symbol = "🌿 ";  # The leaf symbol you're seeing
                style = "green";
            };
            
            git_status = {
                format = "[$all_status]($style)";
                style = "red";
                # ! mark means there are uncommitted changes
                # [!] specifically indicates modified files
                conflicted = "🚨";
                modified = "!";
                untracked = "?";
            };
            
            # Overall prompt format
            format = ''
                $username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character
            '';
            
            # Prompt character
            character = {
                success_symbol = "[➜](bold green)";
                error_symbol = "[✗](bold red)";
            };
        };
    };
}