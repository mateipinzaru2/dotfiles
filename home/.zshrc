# Uncomment to use the profiling module
# zmodload zsh/zprof

# zsh completions
autoload -Uz compinit
compinit

# Starship
eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship.toml

# Terminal specific configurations
if [[ $TERM_PROGRAM = "WarpTerminal" ]] 
  then 
    # Warpify subshell
    printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'
  else
    # auto suggestions
    source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
    # syntax highlighting
    source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

# curl
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# zoxide
eval "$(zoxide init zsh)"

# Broot
source ~/.config/broot/launcher/bash/br

# Switch
source <(switcher init zsh)
source <(compdef _switcher switch)

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
function f {
  local dir=${1:-~}
  local file=$(
    command rg --files \
       --hidden \
       --glob '!.git/*' \
       --glob '!.venv/*' \
       --glob '!pkg/mod/*' \
       --glob '!.terraform/*' \
       --glob '!Library/*' \
       "$dir" | 
    command fzf --preview 'bat --color=always {}' \
       --bind 'ctrl-/:change-preview-window(down|hidden|)' \
       --bind 'alt-left:backward-word' \
       --bind 'alt-right:forward-word' \
       --bind 'ctrl-w:backward-kill-word'
  )
  if [ -n "$file" ]; then
    echo "Select an option:"
    echo "1. Open with VS Code"
    echo "2. Open with default macOS app"
    echo "3. Reveal in Finder"
    echo "4. Copy path"
    read "?Option: " option
    case $option in
      1) code "$file" ;;
      2) open "$file" ;;
      3) open -R "$file" ;;
      4) echo -n "$file" | pbcopy ;;
      *) echo "Invalid option" ;;
    esac
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
alias cd="z"
alias cdi="zi"
alias k="kubectl"
alias klogin="kubelogin convert-kubeconfig -l azurecli"
alias s="switch"
alias lg="lazygit"
common_flags="\
  --long \
  --octal-permissions \
  --no-permissions \
  --all \
  --group-directories-first \
  --git \
  --git-repos \
  --changed \
  --icons=always \
  --color=always \
  --ignore-glob='*.DS_Store*'"
alias ls="eza $common_flags --git-ignore"
alias lsg="eza $common_flags"
alias lst="eza $common_flags --git-ignore --tree"
alias lstg="eza $common_flags --tree"

# Uncomment to use the profiling module
# zprof