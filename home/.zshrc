# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Starship
eval "$(starship init zsh)"
if [[ $TERM_PROGRAM = "WarpTerminal" ]]; then
  export STARSHIP_CONFIG=~/.config/starship_warp.toml
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_CTRL_T_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!.terraform/*"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" --glob "!.terraform/*"'

# Broot
source /Users/mateipinzaru/.config/broot/launcher/bash/br

# VS Code
export EDITOR="code"
export GIT_EDITOR="code"
export VISUAL="code"

# Git
git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
git config --global interactive.diffFilter "diff-so-fancy --patch"
git config --global color.ui true
git config --global color.diff-highlight.oldNormal    "red bold"
git config --global color.diff-highlight.oldHighlight "red bold 52"
git config --global color.diff-highlight.newNormal    "green bold"
git config --global color.diff-highlight.newHighlight "green bold 22"
git config --global color.diff.meta       "11"
git config --global color.diff.frag       "magenta bold"
git config --global color.diff.func       "146 bold"
git config --global color.diff.commit     "yellow bold"
git config --global color.diff.old        "red bold"
git config --global color.diff.new        "green bold"
git config --global color.diff.whitespace "red reverse"

# App Aliases
alias k="kubectl"
alias ls="ls-go -n -l -a -S -L"
alias lst="ls-go -n -l -a -S -L -r"
alias bat="bat --theme=\$(defaults read -globalDomain AppleInterfaceStyle &> /dev/null && echo default || echo GitHub)"
alias klogin="kubelogin convert-kubeconfig -l azurecli"
alias b="br -sdp --show-git-info"
alias f="fzf"

# Navigation Aliases
alias saggit="cd ~/Work/SAG/git"
alias tf="cd ~/Work/SAG/git/terraform"
alias home="cd ~"
alias homesick="cd ~/.homesick/repos/dotfiles"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
