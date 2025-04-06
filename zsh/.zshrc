# =========================================================
# ⚠️ DO NOT edit ~/.zshrc directly.
# This file is a symbolic link pointing to:
#     ~/dotfiles/Zsh/.zshrc
#
# To make shared changes, edit the file above.
# To add machine-specific changes, use ~/.zshrc.local
# =========================================================

#  Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# Basic settings
setopt no_beep
setopt auto_pushd
setopt pushd_ignore_dups
setopt hist_ignore_dups
setopt auto_cd
setopt inc_append_history
setopt share_history 
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000         
SAVEHIST=1000000

#Complement
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'
zstyle ':completion:*' format '%B%F{blue}%d%f%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice depth=1; zinit light romkatv/powerlevel10k

zinit ice from"gh-r" as"program"
zinit load ajeetdsouza/zoxide
eval "$(zoxide init zsh)"

zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:*' fzf-command fzf
zstyle ':fzf-tab:*' fzf-flags --height=60% --layout=reverse

g() {
  open -a "Arc" "https://www.google.com/search?q=${*}"
}

zinit light zsh-users/zsh-autosuggestions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load local settings if present
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi
zinit light zsh-users/zsh-syntax-highlighting
