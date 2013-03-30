# {{{ Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
zstyle ':completion::complete:*' use-cache 1

setopt RM_STAR_WAIT
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE
setopt NUMERIC_GLOB_SORT
setopt autocd extendedglob notify correct

bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'

autoload -Uz compinit
compinit
# }}} End of lines added by compinstall

# My Own custom modification

# {{{ Custom key binding
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey ';5D' emacs-backward-word
bindkey ';5C' emacs-forward-word
bindkey "\e[3~" delete-char
# }}}

source ~/.myscripts/shell/aliases

#source ~/.myscripts/shell/asciiart
source ~/.myscripts/zsh/history-substring-search.zsh
source ~/.myscripts/zsh/git-prompt/zshprompt.sh

emacs-backward-word() {
  local WORDCHARS="${WORDCHARS:s@/@}"
  zle backward-word
}
zle -N emacs-backward-word

zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

autoload -U promptinit
promptinit
prompt walters
setopt PROMPT_SUBST
#PROMPT='%(!.%F{red}.%F{yellow})%1~ %f%(!.%F{red}.%F{blue})%#%f '

PROMPT='$(git_super_status) %f%(!.%F{red}.%F{yellow})ϑ%f '


case $TERM in xterm*)
	precmd () {
		print -Pn "\e]0;%n@%m: %~\a"
	}
	;;
esac
