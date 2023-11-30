### homebrew
typeset -U path PATH
path=(
	/opt/homebrew/bin(N-/)
	/usr/local/bin(N-/)
	$path
)

if [[ "${(L)$( uname -s )}" == darwin ]] && (( $+commands[arch] )); then
	alias ibrew="arch -arch x86_64 /usr/local/bin/brew"
	alias x64='exec arch -arch x86_64 "$SHELL"'
	alias a64='exec arch -arch arm64e "$SHELL"'
fi


### zinit
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

### zinit plugin
zinit ice wait'!0'; zinit light zsh-users/zsh-autosuggestions
zinit ice wait'!0'; zinit light zdharma/fast-syntax-highlighting
zinit ice wait'!0'; zinit light zdharma/history-search-multi-word

### tmux
# Loading tmux first, to prevent jumps when tmux is loaded after .zshrc
# It will only be loaded on first start
zinit ice atinit"
        ZSH_TMUX_FIXTERM=true;
        ZSH_TMUX_AUTOSTART=true;
        ZSH_TMUX_AUTOCONNECT=true;"
zinit snippet OMZP::tmux
tmux source-file ~/.tmux.conf

### theme
DEFAULT_USER='hitsuji-haneta'
zinit light starship/starship
eval "$(starship init zsh)"

### color
export LSCOLORS=gxfxcxbxdxegedabagaggx


# autosuggestions
export TERM=xterm-256color

# cdr 
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs


# fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--color=fg+:11 --height 70% --reverse --multi'

# bat
export BAT_THEME='gruvbox-dark'

# anyframe
zinit light mollifier/anyframe
zstyle ":anyframe:selector:" use fzf

bindkey '^rr' anyframe-widget-checkout-git-branch
bindkey '^r^r' anyframe-widget-checkout-git-branch

bindkey '^rt' anyframe-widget-insert-git-branch
bindkey '^r^t' anyframe-widget-insert-git-branch

bindkey '^ri' anyframe-widget-insert-filename
bindkey '^r^i' anyframe-widget-insert-filename

bindkey '^re' anyframe-widget-cdr
bindkey '^r^e' anyframe-widget-cdr


### anyenv
eval "$(anyenv init -)"
### nodenv
export PATH="$HOME/.anyenv/envs/nodenv/shims:$PATH"


### option
setopt equals 
setopt magic_equal_subst
setopt share_history
setopt histignorealldups
setopt auto_cd
setopt no_beep
setopt auto_param_slash
setopt auto_param_slash


### alias
alias grep='grep --color=auto'

### exa
if [[ $(command -v exa) ]]; then
  alias e='exa -GF --icons --git'
  alias ls=e
  alias ea='exa -aGF --icons --git'
  alias la=ea
  alias ee='exa -aahlGF --icons --git'
  alias ll=ee
  alias et='exa -T -L 3 -a -I "node_modules|.git|.cache" --icons'
  alias lt=et
  alias eta='exa -T -a -I "node_modules|.git|.cache" --color=always --icons | less -r'
  alias lta=eta
  alias l='clear && ls'
fi

### Go
export 'GO111MODULE=on'
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"



### gcloud
source "$(ibrew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(ibrew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"



### kubenetes
source <(kubectl completion zsh)
alias k='kubectl'
complete -F __start_kubectl k


### Rust
export CARGO_HOME="$HOME/.cargo"
export PATH="$CARGO_HOME/bin:$PATH"


### AWS CLI
export PATH=~/.local/bin:$PATH


### iterm2 integration
source ~/.iterm2_shell_integration.zsh

### neovim
alias vi='nvim'

### lazygit
alias lg='lazygit'

export PATH="$PATH:/Users/hitsuji-haneta/.foundry/bin"

### git
export PATH="/opt/homebrew/bin/git:$PATH"

# pnpm
export PNPM_HOME="/Users/hitsuji-haneta/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# docker (colima)
export DOCKER_HOST="unix://$HOME/.colima/docker.sock"
