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

# Broot
source "$HOME/.config/broot/launcher/bash/br"

# VS Code
export EDITOR="code -w"
export GIT_EDITOR="code -w"
export VISUAL="code -w"
function m {
    man $1 | col -bx | open -fa /Applications/Visual\ Studio\ Code.app
}

# App Aliases
alias k="kubectl"
alias ls="eza --long --total-size --octal-permissions --no-permissions --all \
 --git --git-ignore --git-repos --changed --group-directories-first --icons=always --color=always"
alias lst="eza --long --total-size --octal-permissions --no-permissions --all \
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
