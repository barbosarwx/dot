
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# ------- Custom


## history

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000

set -o vi
shopt -s histappend # ensures that the command history from your current session is appended to the history file when you exit the shell

# bash shell options
### shopt is for BASHOPTS, set is for SHELLOPTS

shopt -s checkwinsize # enables $COLUMNS and $ROWS
shopt -s expand_aliases # allows you to use aliases in your commands as if they were regular commands
shopt -s globstar # allows the use of ** as a recursive wildcard in glob patterns
shopt -s dotglob # allows you to match hidden files when using wildcards like * or ?.
shopt -s extglob # allows the use of extended globbing patterns

# path
export
PATH="/home/willianmb/.local/bin:/usr/local/sbin:/usr/local/bin:"$SCRIPTS":/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/home/linuxbrew/.linuxbrew/bin"

# cdpath
export CDPATH=".:$WREPOS:$DOTFILES:$REPOS:$HOME"

# dircolors

if _have dircolors; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# pager

if [[ -x /usr/bin/lesspipe ]]; then
	export LESSOPEN="| /usr/bin/lesspipe %s"
	export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# environment variables

export LANG=en_US.UTF-8 # assuming apt install language-pack-en done
export USER="${USER:-$(whoami)}" # fallback to whoami
export TZ=America/Sao_Paulo
export REPOS="$HOME/Repos"
export WREPOS="$HOME/Wrepos"
export DOTFILES="$REPOS/dot"
export SCRIPTS="$DOTFILES/scripts"
export SNIPPETS="$DOTFILES/snippets"
export HELP_BROWSER=lynx
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export WORKSPACES="$HOME/Workspaces" # container home dirs for mounting
export TERM=xterm-256color
export HRULEWIDTH=73 # affect the behavior or appearance of text-based applications or scripts that utilize it:
export EDITOR=vi
export VISUAL=vi
export EDITOR_PREFIX=vi

export GOBIN="$HOME/.local/bin"

export LESS="-iFXR" # enhanced viewing: -i for case-insensitive: -F for paging, -X for no clear, -R for ANSI colors.
export LESS_TERMCAP_mb=$'\e[35m' # magenta
export LESS_TERMCAP_md=$'\e[33m' # yellow
export LESS_TERMCAP_me=$'\e[0m'  # reset to default
export LESS_TERMCAP_se=$'\e[0m'  # reset to default
export LESS_TERMCAP_so=$'\e[34m' # blue
export LESS_TERMCAP_ue=$'\e[0m'  # reset to default
export LESS_TERMCAP_us=$'\e[4m'  # underline

# ------ local utility functions

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

## keyboard
_have setxkbmap && test -n "$DISPLAY" && setxkbmap -layout us -variant intl &>/dev/null #only works if you have X and are using graphic Linux desktop

## auto-completion
_have terraform && complete -C /usr/bin/terraform terraform
_have terraform && complete -C /usr/bin/terraform tf
_have kubectl && . <(kubectl completion bash 2>/dev/null)

_have ansible && . <(register-python-argcomplete3 ansible)
_have ansible-config && . <(register-python-argcomplete3 ansible-config)
_have ansible-console && . <(register-python-argcomplete3 ansible-console)
_have ansible-doc && . <(register-python-argcomplete3 ansible-doc)
_have ansible-galaxy && . <(register-python-argcomplete3 ansible-galaxy)
_have ansible-inventory && . <(register-python-argcomplete3 ansible-inventory)
_have ansible-playbook && . <(register-python-argcomplete3 ansible-playbook)
_have ansible-pull && . <(register-python-argcomplete3 ansible-pull)
_have ansible-vault && . <(register-python-argcomplete3 ansible-vault)

## aliases
unalias -a
alias ip='ip -c'
alias '?'=duck
alias '??'=gpt
alias '???'=google
alias dot='cd $DOTFILES'
alias scripts='cd $SCRIPTS'
alias ls='ls -h --color=auto'
alias free='free -h'
alias tree='tree -a'
alias df='df -h'
alias chmox='chmod +x'
alias diff='diff --color=always'
alias temp='cd $(mktemp -d)'
alias clear='printf "\e[H\e[2J"'
alias c='printf "\e[H\e[2J"'
alias path='echo -e ${PATH//:/\\n}'


_have vim && alias vi=vim

# smart prompt

PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
    # Various color codes for text coloring
    local P='$' dir="${PWD##*/}" B countme short long double \
        r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
        u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
        b='\[\e[36m\]' x='\[\e[0m\]'

		# Get the first three characters of the hostname
    local hostname_part="$(hostname | cut -c 1-3)"

    # Check if the user is root and adjust colors accordingly
    [[ $EUID == 0 ]] && P='#' && u=$r && p=$u

    # Handle special cases for the current directory
    [[ $PWD = / ]] && dir=/
    [[ $PWD = "$HOME" ]] && dir='~'

    # Get the current Git branch (if applicable)
    B=$(git branch --show-current 2>/dev/null)
    [[ $dir = "$B" ]] && B=.

    # Define the countme string for length calculation
		countme="$USER$PROMPT_AT$hostname_part:$dir($B)\$ "

    # Customize the prompt based on various conditions
    [[ $B == master || $B == main ]] && b="$r"
    [[ -n "$B" ]] && B="$g($b$B$g)"

    # Determine the style of the prompt (short, long, or double-line)
		short="$u\u$g$PROMPT_AT$h$hostname_part$g:$w$dir$B$p$P$x "
    long="$g╔ $u\u$g$PROMPT_AT$h$hostname_part$g:$w$dir$B\n$g╚ $p$P$x "
    double="$g╔ $u\u$g$PROMPT_AT$h$hostname_part$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

    # Set the PS1 variable based on prompt length
    if ((${#countme} > PROMPT_MAX)); then
        PS1="$double"
    elif ((${#countme} > PROMPT_LONG)); then
        PS1="$long"
    else
        PS1="$short"
    fi
}

# Set the PROMPT_COMMAND to call the __ps1 function
PROMPT_COMMAND="__ps1"

