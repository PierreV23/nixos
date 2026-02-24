# yes this is all AI slop

# Function to display kitty shortcuts
kitty-help() {
  local cyan="\033[1;36m"
  local yellow="\033[1;33m"
  local gray="\033[2m"
  local reset="\033[0m"

  echo "\n${cyan}═══ Kitty Keyboard Shortcuts ═══${reset}\n"

  echo "${yellow}Tabs:${reset}"
  echo "  Ctrl+Shift+T         New tab"
  echo "  Ctrl+Shift+Q         Close tab"
  echo "  Ctrl+Shift+Right     Next tab"
  echo "  Ctrl+Shift+Left      Previous tab"
  echo "  Ctrl+Shift+.         Move tab forward"
  echo "  Ctrl+Shift+,         Move tab backward"
  echo "  Ctrl+Shift+Alt+T     Rename tab"
  echo ""

  echo "${yellow}Windows:${reset}"
  echo "  Ctrl+Shift+Enter     New window"
  echo "  Ctrl+Shift+N         New OS window"
  echo "  Ctrl+Shift+W         Close window"
  echo "  Ctrl+Shift+]         Next window"
  echo "  Ctrl+Shift+[         Previous window"
  echo "  Ctrl+Shift+F         Move window forward"
  echo "  Ctrl+Shift+B         Move window backward"
  echo "  Ctrl+Shift+\`         Move window to top"
  echo "  Ctrl+Shift+R         Resize window (interactive)"
  echo ""

  echo "${yellow}Layouts:${reset}"
  echo "  Ctrl+Shift+L         Cycle layouts (stack/tall/fat/grid/etc)"
  echo ""

  echo "${yellow}Scrolling:${reset}"
  echo "  Ctrl+Shift+Up        Scroll line up"
  echo "  Ctrl+Shift+Down      Scroll line down"
  echo "  Ctrl+Shift+Page Up   Scroll page up"
  echo "  Ctrl+Shift+Page Dn   Scroll page down"
  echo "  Ctrl+Shift+Home      Scroll to top"
  echo "  Ctrl+Shift+End       Scroll to bottom"
  echo "  Ctrl+Shift+H         Browse scrollback in pager"
  echo "  Ctrl+Shift+G         Browse last command output"
  echo ""

  echo "${yellow}Clipboard & Font:${reset}"
  echo "  Ctrl+Shift+C         Copy to clipboard"
  echo "  Ctrl+Shift+V         Paste from clipboard"
  echo "  Ctrl+Shift+S         Paste from selection"
  echo "  Ctrl+Shift+Equal     Increase font size"
  echo "  Ctrl+Shift+Minus     Decrease font size"
  echo "  Ctrl+Shift+Backspace Reset font size"
  echo ""

  echo "${yellow}Other:${reset}"
  echo "  Ctrl+Shift+F11       Toggle fullscreen"
  echo "  Ctrl+Shift+F2        Edit kitty.conf"
  echo "  Ctrl+Shift+F5        Reload kitty.conf"
  echo "  Ctrl+Shift+F6        Show current config"
  echo "  Ctrl+Shift+Delete    Clear terminal"
  echo "  Ctrl+Shift+E         Open URL with hints"
  echo "  Ctrl+Shift+Escape    Kitty shell (remote control)"
  echo "  Ctrl+Shift+U         Input unicode character"

  echo "\n${gray}Type 'kitty-help' to see this again${reset}\n"
}

# Use kitty ssh kitten and auto-launch remote zsh with portable config
if [[ "$TERM" == "xterm-kitty" ]]; then
    ssh() {
        command kitty +kitten ssh "$@" -t 'ZDOTDIR=$HOME/.pierrev23-stuff exec $HOME/.pierrev23-stuff/.zsh-bin/zsh'
    }
fi

# Setup portable zsh environment on a remote host
setup-remote-zsh() {
    local host="$1"
    local cache="$HOME/.cache/zsh-static"
    local remote_dir=".pierrev23-stuff"

    [[ -z "$host" ]] && echo "Usage: setup-remote-zsh <host>" && return 1

    if [[ ! -f "$cache" ]]; then
        echo "Downloading static zsh..."
        local tmp=$(mktemp -d)
        wget -qO- https://github.com/romkatv/zsh-bin/releases/download/v3.0.1/zsh-5.8-linux-x86_64.tar.gz | tar xz -C "$tmp"
        mkdir -p "$(dirname "$cache")"
        mv "$tmp/zsh-5.8-linux-x86_64/bin/zsh" "$cache"
        rm -rf "$tmp"
    fi

    echo "Uploading zsh binary..."
    command ssh "$host" "mkdir -p $remote_dir/.zsh-bin"
    command scp "$cache" "$host:$remote_dir/.zsh-bin/zsh-static"
    command ssh "$host" "mv $remote_dir/.zsh-bin/zsh-static $remote_dir/.zsh-bin/zsh && chmod +x $remote_dir/.zsh-bin/zsh"

    echo "Uploading config..."
    command scp "$HOME/.zshrc.portable" "$host:$remote_dir/.zshrc"

    echo "Done. Connect with: ssh $host"
}

# Display shortcuts on first kitty launch
if [[ $TERM == "xterm-kitty" && -z "$KITTY_HELP_SHOWN" ]]; then
  export KITTY_HELP_SHOWN=1
  kitty-help
fi

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Fix keybindings
bindkey "^[[3~" delete-char              # Delete
bindkey "^[[H" beginning-of-line         # Home
bindkey "^[[F" end-of-line               # End
bindkey "^[[1;5C" forward-word           # Ctrl+Right
bindkey "^[[1;5D" backward-word          # Ctrl+Left
bindkey "^[[3;5~" kill-word              # Ctrl+Delete

# Enable git info
autoload -Uz vcs_info
setopt PROMPT_SUBST

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats ' %F{green}:%b%f%u%c%m'
zstyle ':vcs_info:git:*' actionformats ' %F{green}:%b|%a%f%u%c%m'

# Add untracked files indicator
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
     git status --porcelain | grep -q '^?? ' 2> /dev/null ; then
    hook_com[misc]='?'
  fi
}

# Track command execution time
preexec() {
  cmd_start_time=$SECONDS
}

precmd() {
  vcs_info

  # Set window title
  print -Pn "\e]0;zsh shell\a"

  # Build path string (avoids subshell fork in PROMPT)
  local git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n $git_root ]]; then
    local repo_name=${git_root:t}
    local before_repo=${git_root:h}
    local rel_path=${PWD#$git_root}

    if [[ $before_repo == / ]]; then
      if [[ -n $rel_path ]]; then
        prompt_path_str=" %F{magenta}$repo_name%f %F{cyan}$rel_path%f"
      else
        prompt_path_str=" %F{magenta}$repo_name%f "
      fi
    else
      if [[ -n $rel_path ]]; then
        prompt_path_str=" %F{cyan}$before_repo/%f %F{magenta}$repo_name%f %F{cyan}$rel_path%f"
      else
        prompt_path_str=" %F{cyan}$before_repo/%f %F{magenta}$repo_name%f "
      fi
    fi
  else
    prompt_path_str=" %~"
  fi

  # Calculate execution time
  if [[ -n $cmd_start_time ]]; then
    local elapsed=$((SECONDS - cmd_start_time))
    local mins=$(((elapsed % 3600) / 60))
    local secs=$((elapsed % 60))

    if (( elapsed >= 1 )); then
      if (( elapsed >= 60 )); then
        cmd_exec_time=" took %F{yellow}${mins}m${secs}s%f"
      else
        cmd_exec_time=" took %F{yellow}${secs}s%f"
      fi
    else
      cmd_exec_time=""
    fi
    unset cmd_start_time
  else
    cmd_exec_time=""
  fi
}

# Build the prompt
PROMPT='
%F{cyan}↑%f %(?.%F{green}SUCCESS%f.%F{red}ERROR%f)${cmd_exec_time}
%F{yellow}[%D{%H:%M:%S}]%f %F{blue}%n%f@%F{white}%m%f${prompt_path_str}${vcs_info_msg_0_}
'
