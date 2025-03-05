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
    # syntax highlighting
    source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
    # auto suggestions
    source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi

# direnv
eval "$(direnv hook zsh)"

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
       --glob '!*.npm/*' \
       --glob '!*.vscode/*' \
       --glob '!Pictures/*' \
       --glob '!*.kube/*' \
       --glob '!*.local/*' \
       --glob '!.cache/*' \
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
    echo "5. Change to parent directory"
    read "?Option: " option
    case $option in
      1) code "$file" ;;
      2) open "$file" ;;
      3) open -R "$file" ;;
      4) echo -n "$file" | pbcopy ;;
      5) cd "$(dirname "$file")" ;;
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

# Eza
common_flags=(
  '--all'
  '--long'
  '--no-permissions'
  '--octal-permissions'
  '--group-directories-first'
  '--git'
  '--git-repos'
  '--changed'
  '--icons=always'
  '--color=always'
  '--ignore-glob=*.DS_Store*'
)
tree_extra_flags='--only-dirs --tree'
_eza_call() {
  local add_git_ignore=$1
  local extra_flags=$2
  shift 2
  local args=("$@")
  local full_flags=("${common_flags[@]}")
  [[ -n "$extra_flags" ]] && full_flags+=(${=extra_flags})
  (( add_git_ignore )) && full_flags+=(--git-ignore)
  eza "${full_flags[@]}" "${args[@]}"
}
ls()   { _eza_call 1 "" "$@"; }
lsg()  { _eza_call 0 "" "$@"; }
lst()  { _eza_call 1 "$tree_extra_flags --ignore-glob=*.terraform*" "$@"; }
lstg() { _eza_call 0 "$tree_extra_flags" "$@"; }

# App Aliases
alias cd="z"
alias cdi="zi"
alias br="br -s"
alias k="kubectl"
alias klogin="kubelogin convert-kubeconfig -l azurecli"
alias s="switch"
alias lg="lazygit"

# Uncomment to use the profiling module
# zprof