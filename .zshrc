# -------------------------------
# Basic History & Keybindings
# -------------------------------
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e             # Emacs keybindings

# -------------------------------
# Completion
# -------------------------------
autoload -Uz compinit
compinit

# Enable case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# -------------------------------
# Colors & Prompt
# -------------------------------
autoload -U colors && colors
setopt PROMPT_SUBST

# Function to show current Git branch
git_branch() {
    local branch git_status_count
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || return
    git_status_count=$(git status --porcelain 2>/dev/null | wc -l)
    if [[ $git_status_count -gt 0 ]]; then
        echo "%F{magenta}($branch*)%f"
    else
        echo "%F{magenta}($branch)%f"
    fi
}

# Simple colored prompt: user@host dir $
PROMPT='%F{green}%n@%m%f %F{blue}%~%f$(git_branch) %F{yellow}$%f '

# -------------------------------
# Aliases (like Bash)
# -------------------------------
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias gs='git status'
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
alias ...='cd ../..'

# -------------------------------
# Useful Options
# -------------------------------
# Auto-cd: type a dir name to cd
setopt AUTO_CD

# Correct minor typos in commands
setopt CORRECT

# Share history across sessions
setopt SHARE_HISTORY

# Don't store duplicates
setopt HIST_IGNORE_ALL_DUPS

# -------------------------------
# Plugins (manual, since no Oh My Zsh)
# -------------------------------
# Syntax highlighting
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Autosuggestions
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# -------------------------------
# Tmux Integration
# -------------------------------
# Automatically switch to tmux if inside a terminal and not already in tmux
#if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#    tmux attach || tmux new
#fi

# -------------------------------
# Load custom scripts (optional)
# -------------------------------
# For personal scripts in ~/bin
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH"
fi

# -------------------------------
# End of .zshrc
# -------------------------------

alias dotfiles='/usr/bin/git --git-dir=/home/ben/.dotfiles/ --work-tree=/home/ben'
