# Uncomment to use the profiling module
# zmodload zsh/zprof

# Starship
eval "$(starship init zsh)"
if [[ $TERM_PROGRAM = "WarpTerminal" ]] 
  then 
    export STARSHIP_CONFIG=~/.config/starship_warp.toml
    # Warpify subshell
    printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'
  else
    export STARSHIP_CONFIG=~/.config/starship.toml
    # syntax highlighting
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Broot
source ~/.config/broot/launcher/bash/br

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function f {
  local file=$(rg --files --hidden --glob '!.git/*' --glob '!.terraform/*' --glob '!Library/*' ~ | fzf \
  --preview 'bat --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)' \
  --bind 'alt-left:backward-word' \
  --bind 'alt-right:forward-word' \
  --bind 'ctrl-w:backward-kill-word')
  if [ -n "$file" ]; then
    code "$file"
  fi
}
function d {
  local dir=$(find $HOME -type d -not -path "$HOME/Library/*" -print0 | fzf --read0 \
  --bind 'alt-left:backward-word' \
  --bind 'alt-right:forward-word' \
  --bind 'ctrl-w:backward-kill-word')
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

# VS Code
export EDITOR="code -w"
export GIT_EDITOR="code -w"
export VISUAL="code -w"
function m {
    man $1 | col -bx | open -fa /Applications/Visual\ Studio\ Code.app
}

# Copilot
function gcshell {
  gh copilot suggest -t 'shell' $1
}
function gcgit {
  gh copilot suggest -t 'git' $1
}
function gcgh {
  gh copilot suggest -t 'gh' $1
}
function explain {
  gh copilot explain $1
}

# App Aliases
alias k="kubectl"
alias klogin="kubelogin convert-kubeconfig -l azurecli"
alias lg="lazygit"
alias ls="eza --long --octal-permissions --no-permissions --all --group-directories-first \
--git --git-repos --git-ignore --changed --icons=always --color=always"
alias lsg="eza --long --octal-permissions --no-permissions --all --group-directories-first \
--git --git-repos --changed --icons=always --color=always"
alias lst="eza --long --octal-permissions --no-permissions --all --group-directories-first \
--git --git-repos --git-ignore --changed --icons=always --color=always --tree"
alias lstg="eza --long --octal-permissions --no-permissions --all --group-directories-first \
--git --git-repos --changed --icons=always --color=always --tree"

# Navigation Aliases
alias home="cd ~"
alias homesick="cd ~/.homesick/repos/dotfiles/home"

# Uncomment to use the profiling module
# zprof