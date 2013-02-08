#path
export PATH=/usr/local/bin:/System/Library/Frameworks/JavaVM.framework/Versions/1.6.0/Commands:/usr/local/mysql/bin:$PATH
# MacPorts Installer addition on 2011-01-05_at_14:13:32: adding an appropriate PATH variable for use with MacPorts.
export PATH=$PATH:/opt/local/sbin:/opt/local/bin
# Finished adapting your PATH environment variable for use with MacPorts.

# Setting PATH for Python 3.2
# The orginal version is saved in .profile.pysave
export PATH=$HOME/bin:/Library/Frameworks/Python.framework/Versions/3.2/bin:$PATH

#put home dir in PATH
export PATH=$HOME:$PATH

#Color table from: http://www.understudy.net/custom.html
fg_black=%{$'\e[0;30m'%}
fg_red=%{$'\e[0;31m'%}
fg_green=%{$'\e[0;32m'%}
fg_brown=%{$'\e[0;33m'%}
fg_blue=%{$'\e[0;34m'%}
fg_purple=%{$'\e[0;35m'%}
fg_cyan=%{$'\e[0;36m'%}
fg_lgray=%{$'\e[0;37m'%}
fg_dgray=%{$'\e[1;30m'%}
fg_lred=%{$'\e[1;31m'%}
fg_lgreen=%{$'\e[1;32m'%}
fg_yellow=%{$'\e[1;33m'%}
fg_lblue=%{$'\e[1;34m'%}
fg_pink=%{$'\e[1;35m'%}
fg_lcyan=%{$'\e[1;36m'%}
fg_white=%{$'\e[1;37m'%}
#Text Background Colors
bg_red=%{$'\e[0;41m'%}
bg_green=%{$'\e[0;42m'%}
bg_brown=%{$'\e[0;43m'%}
bg_blue=%{$'\e[0;44m'%}
bg_purple=%{$'\e[0;45m'%}
bg_cyan=%{$'\e[0;46m'%}
bg_gray=%{$'\e[0;47m'%}
#Attributes
at_normal=%{$'\e[0m'%}
at_bold=%{$'\e[1m'%}
at_italics=%{$'\e[3m'%}
at_underl=%{$'\e[4m'%}
at_blink=%{$'\e[5m'%}
at_outline=%{$'\e[6m'%}
at_reverse=%{$'\e[7m'%}
at_nondisp=%{$'\e[8m'%}
at_strike=%{$'\e[9m'%}
at_boldoff=%{$'\e[22m'%}
at_italicsoff=%{$'\e[23m'%}
at_underloff=%{$'\e[24m'%}
at_blinkoff=%{$'\e[25m'%}
at_reverseoff=%{$'\e[27m'%}
at_strikeoff=%{$'\e[29m'%}
 
setopt PROMPT_SUBST

# Autoload zsh functions.
fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)
 
#git branch in prompt
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions


# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'
 
# show git status in prompt
parse_git_branch() {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /';
}

# autocompletion for git branch names
_complete_git() {
 if [ -d .git ]; then
   branches=`git branch -a | cut -c 3-`
   tags=`git tag`
   cur="${COMP_WORDS[COMP_CWORD]}"
   COMPREPLY=( $(compgen -W "${branches} ${tags}" -- ${cur}) )
 fi
}
#complete -F _complete_git git co
#complete -F _complete_git git checkout
#complete -F _complete_git git merge
#complete -F _complete_git git rebase
#complete -F _complete_git git rebase -i
#complete -F _complete_git git branch
#complete -F _complete_git git add
#complete -F _complete_git gb
#complete -F _complete_git gbd
#complete -F _complete_git gm
#complete -F _complete_git gpo

# Set the prompt.
#PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '

PROMPT=$'
${fg_lgreen}%n@${at_underl}%m${at_underloff}${fg_white}[${fg_cyan}%~${fg_white}] $(prompt_git_info)
${fg_white}[${fg_green}%T${fg_white}]:${at_normal} '
 
#Set the auto completion on
autoload -U compinit
compinit

#colors.
autoload -U colors && colors
 
#Lets set some options
setopt correctall
setopt autocd
setopt auto_resume
 
## Enables the extgended globbing features
setopt extendedglob
 
####
# bindkey
# Esc = undo
bindkey "^[" undo

# Pipe the current command through less
bindkey -s "\el" " 2>&1|less^M"

#Set some ZSH styles
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
 
HISTFILE=~/.zsh-histfile
HISTSIZE=1000
SAVEHIST=1000
 
#Aliases
##ls, the common ones I use a lot shortened for rapid fire usage
alias ls='ls -G'      #I like color
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
 
##cd, because typing the backslash is ALOT of work!!
#alias .='cd ../'
#alias ..='cd ../../'
#alias ...='cd ../../../'
#alias ....='cd ../../../../'
 
# SSH aliases - short cuts to ssh to a host
alias -g shost='ssh -p 9999 user@host.com'
 
# Screen aliases - add a new screen , or entire session, name it, then ssh to the host
alias sshost='screen -t HOST shost'

# git aliases
alias gst='git status'

alias gd='git diff | mate'
alias gdd='git diff develop'

alias grd='git rebase develop'

alias gm='git merge --no-ff'

alias gc='git commit -v'
alias gca='git commit -v -a'
alias gco='git checkout'
alias gcot='git checkout -t' # co and track a branch
alias gcob='git checkout -b' # create and co a branch
alias gcod='git checkout develop'
alias gcom='git checkout master'

alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -D'

alias gp='git pull'
alias gpo='git push origin'
alias gpom='git pull origin master && git push origin master'
alias gpod='git pull origin develop && git push origin develop'

alias gitx='open /Applications/GitX.app/'

#other aliases
alias irc='irssi --connect=irc.efnet.org'
alias scr="screen"
alias Grep="grep"
alias less="less -mR"

#function aliases
function pman() {
  man -t $1 | open -f -a /Applications/Preview.app
}

#color ps
function cps() {
  ps auxm | awk '{ print "\033[1;31m"$2"\033[0m\t""\033[1;30m"$6/1024" MB\033[0m "; for (i=11; i<=NF; i++) printf("%s%s", $i, (i==NF) ? "\n" : OFS) }' | awk '{ if ( ( NR % 2 ) == 0 ) { printf("%s\n",$0) } else { printf("%s ",$0) } }' | awk '{ print ( (NR==1) ? "\033[1;34mPID\tSIZE\t    COMMAND" : $0 ) }' | less
}

# Set colors for man pages.
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;37m") \
    LESS_TERMCAP_md=$(printf "\e[1;37m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[0;36m") \
    man "$@"
}

# Display series of dots during completion
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# Alt+S inserts sudo at beginning of line
insert_sudo () { zle beginning-of-line; zle -U "sudo " }
zle -N insert-sudo insert_sudo
bindkey "^[s" insert-sudo

####
# Completion
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Precede different sections in various completions with headers.
# IE:  ssh is separated into "remote host name" and "login name"
zstyle ':completion:*' group-name "${(@):-}"

# allow approximate
zstyle ':completion:*' completer _complete _match  _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

## tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Autocompletion of hosts, based on ssh known_hosts and config files

# zstyle ':completion:*:ssh:*' hosts '(${${${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*\**})'
# if zstyle -t ":completion:${curcontext}:hosts" use-ssh-config; then
#   [[ -r ~/.ssh/config ]] && _cache_hosts+=(${${=${(M)${(f)"$(<~/.ssh/config)"}:#Host*}#Host }:#*[\*\?]*})
# fi
# zstyle -e ':completion:*:ssh:*' hosts 'reply=($(sed -e "s/ .*\$//" -e "s/,.*//g" ~/.ssh/known_hosts ))'
# zstyle -e ':completion::*:*:*:hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'
# Alternative:
#
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
#
# zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')

zstyle ':completion:*:ssh:*' group-order 'users' 'hosts'

# Set up colors, prompts, and messages
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Found %e errors:'
zstyle :compinstall filename $HOME/.zshcompl

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%F{red}%U%B%d%b%u%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' separate-sections 'yes'

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
# zstyle '*' hosts $hosts

# Enable oh-my-zsh agent-forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

#key bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char-or-list
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Include stuff that should only be on this
if [[ -r ~/.localzsh ]]; then
    source ~/.localzsh
fi
