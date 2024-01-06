# Uncomment to use the profiling module
# zmodload zsh/zprof

# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Check which terminal emulator
eval "$(starship init zsh)"
if [[ $TERM_PROGRAM = "WarpTerminal" ]] 
  then 
    # Starship config for Warp
    export STARSHIP_CONFIG=~/.config/starship_warp.toml
    # Warpify subshell
    printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'
  else
    # Starship config for all other terminals
    export STARSHIP_CONFIG=~/.config/starship.toml
    # syntax highlighting for all other terminals
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

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
alias klogin="kubelogin convert-kubeconfig -l azurecli"
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
alias personal="cd ~/Personal"
alias work="cd ~/Work"
alias saggit="cd ~/Work/SAG/git"
alias tf="cd ~/Work/SAG/git/terraform"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

# zprof