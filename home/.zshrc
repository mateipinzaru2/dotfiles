# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Starship
eval "$(starship init zsh)"
if [[ $TERM_PROGRAM = "WarpTerminal" ]] 
  then 
    export STARSHIP_CONFIG=~/.config/starship_warp.toml
  else
    export STARSHIP_CONFIG=~/.config/starship.toml
fi

# syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# az cli
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
source "$HOME/.homesick/repos/dotfiles/home/.completions/az"

# Broot
source "$HOME/.config/broot/launcher/bash/br"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/*' --glob '!.terraform/*'"
export FZF_CTRL_T_COMMAND="rg --files --hidden --glob '!.git/*' --glob '!.terraform/*'"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
function f {
  fzf \
  --preview 'bat --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
}
function d {
  fzf --bind "start:reload(rg --files --hidden --glob '!.git/*' --glob '!.terraform/*' --null \
  | xargs -0 dirname | uniq)"
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
alias ls="eza --long --octal-permissions --no-permissions --all \
--git --git-ignore --git-repos --changed --group-directories-first --icons=always --color=always"
alias lst="eza --long --octal-permissions --no-permissions --all \
--git --git-ignore --git-repos --changed --group-directories-first --icons=always --color=always --tree"
alias klogin="kubelogin convert-kubeconfig -l azurecli"
alias b="br -sdp --show-git-info"

# Navigation Aliases
alias saggit="cd ~/Work/SAG/git"
alias tf="cd ~/Work/SAG/git/terraform"
alias home="cd ~"
alias homesick="cd ~/.homesick/repos/dotfiles/home"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
