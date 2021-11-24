HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
bindkey -e

zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle :compinstall filename '/home/jingyen/.zshrc'

setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt numericglobsort
setopt no_list_ambiguous

WORDCHARS=${WORDCHARS//\/}

setopt extended_glob
setopt AUTOcd

autoload -Uz compinit
compinit
autoload -U +X bashcompinit && bashcompinit
# End of lines added by compinstall

export LESS='--quit-if-one-screen --ignore-case --status-column --LONG-PROMPT --RAW-CONTROL-CHARS --HILITE-UNREAD --tabs=4  --use-color -Dd+r$Du+b'

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-rust \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-bin-gem-node

### End of Zinit's installer chunk

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

export PATH=$PATH:/home/jingyen/.cargo/bin/
export PATH=$PATH:/home/jingyen/.emacs.d/bin/
export PATH=$PATH:/home/jingyen/.config/emacs/bin/
export PATH=$PATH:/home/jingyen/bin/
export PATH=$PATH:/home/jingyen/.local/bin/
export PATH=$PATH:/home/jingyen/.yarn/bin
export PATH=$PATH:/home/jingyen/.pyenv/bin/
export PATH=$PATH:/home/jingyen/go/bin/
export PATH=$PATH:/home/jingyen/.gem/ruby/2.7.0/bin
export PATH="$(yarn global bin):$PATH"
export PATH="$PATH:$HOME/projects/ani-cli"

alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias exa='exa --group-directories-first --time-style=long-iso'
alias ll='exa -lg'
alias la='exa -lag'
alias vim='nvim'
alias gdb='gdb --quiet'
alias ip='ip -color=auto'

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

chpwd_functions=(${chpwd_functions[@]} "_zoxide_hook")

# Fix XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
# export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle

function yta() {
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

# opam configuration
test -r /home/jingyen/.opam/opam-init/init.zsh && . /home/jingyen/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

alias examrecord='ffmpeg -f x11grab -r 1 -video_size 1920x1080 -probesize 20M -threads 1 -i :0.0 -vcodec libx264 -b:v 128k -s hd720'

function memevideo() {
    yt-dlp "ytsearch:$1" -o - | mpv -vo tct --profile=sw-fast --no-terminal -
}

alias htb="sudo openvpn $HOME/Downloads/lab_jingyen.ovpn"
alias thm="sudo openvpn $HOME/Downloads/jingyen.ovpn"

function mkcd {
  last=$(eval "echo \$$#")
  if [ ! -n "$last" ]; then
    echo "Enter a directory name"
  elif [ -d $last ]; then
    echo "\`$last' already exists"
  else
    mkdir $@ && cd $last
  fi
}

zinit pack for ls_colors
