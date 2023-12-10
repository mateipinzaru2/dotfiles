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
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!.terraform/*"'
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!.terraform/*"'
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Broot
source /Users/mateipinzaru/.config/broot/launcher/bash/br

# VS Code
export EDITOR="code"
export GIT_EDITOR="code"
export VISUAL="code"

# App Aliases
alias k="kubectl"
alias ls="ls-go -n -l -a -S -L"
alias lst="ls-go -n -l -a -S -L -r"
alias klogin="kubelogin convert-kubeconfig -l azurecli"
alias b="br -sdp --show-git-info"
alias bat="bat \
  --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && \
  echo default || echo GitHub)"
alias f="fzf \
  --preview 'bat -n --color=always {}' \
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
alias d="fzf \
  --bind 'start:reload(rg --hidden --files --null | xargs -0 dirname | uniq)'"

# Navigation Aliases
alias saggit="cd ~/Work/SAG/git"
alias tf="cd ~/Work/SAG/git/terraform"
alias home="cd ~"
alias homesick="cd ~/.homesick/repos/dotfiles/home"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
