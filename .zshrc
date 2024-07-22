export XDG_CONFIG_HOME="$HOME/.config"
export PATH=$PWD/node_modules/.bin:$PATH
export HOMEBREW_NO_ANALYTICS=1

if [[ -n $SSH_CONNECTION ]]; then
	export EDITOR='vim'
else 
	export EDITOR='nvim'
fi

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/omp.yaml)"
fi

source /opt/homebrew/opt/zinit/zinit.zsh

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit

if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

alias c="$EDITOR"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -rfv"
alias mkdir="mkdir -pv"
alias cd="z"
alias ~="cd ~"
alias p="cd ~/Developer/"
alias dl="cd ~/Downloads/"
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias f="open -a Finder ./"
alias fzf="fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""
alias ls="eza"
alias g="lazygit"
alias cat="bat"

ssh () {
	local ps_res
	ps_res=$(ps -p $(ps -p $$ -o ppid= | xargs) -o comm=)

	if [ "$ps_res" = "tmux" ]; then
		tmux rename-window "ssh:$(echo $argv | cut -d . -f 1)"
		command ssh $argv
		tmux set-window-option automatic-rename "on" >/dev/null
	else
		command ssh $argv
	fi
}

source ~/.secrets

eval "$(thefuck --alias)"
source <(fzf --zsh)
eval "$(zoxide init zsh)"
