
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::docker
zinit snippet OMZP::tmux
zinit snippet OMZP::vscode
zinit snippet OMZP::command-not-found

fpath+=~/.zsh/completions

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[3~' delete-char

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
#zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls -lh --color'
alias ll='ls -alsh --color'
alias vim='nvim'
alias c='clear'
alias mkd='mkdir -p'
alias reboot='sudo reboot'
alias shutdown='sudo shutdown now'
alias cdev='cd ~/dev'
alias cnsync='cd ~/nosync'
alias untar='tar -xvf'
alias targz='tar -czvf'
alias zipf='zip -r'
alias unzipf='unzip -d'
alias cp="cp -i"
alias top="bpytop"
alias bambu="~/dev/BambuStudio/install_dir/bin/bambu-studio &"

# Repeat last command with sudo
alias fuck='sudo $(fc -ln -1)'

. "$HOME/.cargo/env"


# Shell integrations
eval "$(fzf --zsh)"
#eval "$(zoxide init --cmd cd zsh)"

############################################################################
# Liste der benötigten Programme
required_programs=("neofetch" "git" "curl" "vim" "docker" "zsh" "fzf" "tmux")

check_and_install_programs() {
  missing_programs=()

  for program in "${required_programs[@]}"; do
    if ! command -v "$program" >/dev/null 2>&1; then
      missing_programs+=("$program")
    fi
  done

  if [ ${#missing_programs[@]} -gt 0 ]; then
    echo "Following programs are not installed: ${missing_programs[*]}"

    if command -v apt >/dev/null 2>&1; then
      sudo apt update && sudo apt install -y "${missing_programs[@]}"
    elif command -v pacman >/dev/null 2>&1; then
      sudo pacman -Sy --noconfirm "${missing_programs[@]}"
    elif command -v dnf >/dev/null 2>&1; then
      sudo dnf install -y "${missing_programs[@]}"
    elif command -v zypper >/dev/null 2>&1; then
      sudo zypper install -y "${missing_programs[@]}"
    else
      echo "No suitable package manager found."
    fi
  fi
}
check_and_install_programs
##############################################################################

##############################################################################
#HOME_ROUTER_IP="192.168.1.1"
#
#if ping -c 1 -W 1 $HOME_ROUTER_IP > /dev/null 2>&1; then
#    echo "Heimnetz erkannt – Twingate wird gestoppt..."
#    #systemctl --user stop twingate.service
#    #twingate stop
#else
#    echo "Nicht im Heimnetz – Twingate wird gestartet..."
#    #systemctl --user start twingate.service
#    #twingate start
#fi
##############################################################################

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export ANDROID_HOME=/home/mario/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:/usr/local/go/bin
