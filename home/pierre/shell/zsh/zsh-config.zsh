# yes this is all AI slop


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

# Custom path function
prompt_path() {
  local git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n $git_root ]]; then
    local repo_name=$(basename "$git_root")
    local before_repo="${git_root%/*}"
    local rel_path="${PWD#$git_root}"

    if [[ $before_repo == $git_root ]]; then
      # Repo is in root
      if [[ -z $rel_path ]]; then
        echo " %F{magenta}$repo_name%f "
      else
        echo " %F{magenta}$repo_name%f %F{cyan}$rel_path%f"
      fi
    else
      if [[ -z $rel_path ]]; then
        echo " %F{cyan}$before_repo/%f %F{magenta}$repo_name%f "
      else
        echo " %F{cyan}$before_repo/%f %F{magenta}$repo_name%f %F{cyan}$rel_path%f"
      fi
    fi
  else
    echo " %F{cyan}%~%f"
  fi
}

# Return status indicator
prompt_status() {
  echo "%(?.%F{green}SUCCESS%f.%F{red}ERROR%f)"
}

# Build the prompt - ALWAYS show arrow
PROMPT='%F{cyan}↑%f $(prompt_status)${cmd_exec_time}
%F{yellow}[$(date +%H:%M:%S)]%f %F{blue}%n%f@%F{white}%m%f$(prompt_path)${vcs_info_msg_0_}
'
