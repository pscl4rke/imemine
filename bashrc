

#======================================================================#
#                       BASH CONFIGURATION FILE                        #
#======================================================================#


# NON-INTERACTIVE GET-OUT
#   Only continue with these preferences in an interactive session.
#   Otherwise I shall stick to the defaults so that shell scripts
#   behave as the author expected.
[ -z "$PS1" ] && return


# BORROWED FROM UBUNTU DEFAULTS
#   I don't know how much these are needed, but I include them in
#   case it reduces the usability that I've been accustomed to.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# COMMAND COMPLETION
#   Command auto-completion is very handy, but I've had to do
#   some performance tuning here.
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    # This line is (relatively) very time-consuming, so I've
    # cancelled all of the files in /etc/bash_completion.d
    BASH_COMPLETION_DIR=foo
    BASH_COMPLETION_COMPAT_DIR=foo
    . /etc/bash_completion
fi
#   Now I manually include the completion files that I want
#   (They can use uname, userland, have etc.)
UNAME=$( uname -s )
UNAME=${UNAME/CYGWIN_*/Cygwin}
case ${UNAME} in
    Linux|GNU|GNU/*) USERLAND=GNU ;;
    *) USERLAND=${UNAME} ;;
esac
have() {
    unset -v have
    PATH=$PATH:/sbin:/usr/sbin:/usr/local/sbin type $1 &>/dev/null &&
    have="yes"
}
for completer in git tig man ssh apt
do
    source /etc/bash_completion.d/$completer
done


# BASIC OPTIONS
#   I ask bash not to overwrite an existing file using the
#   redirects and to be nice with the history file.  Also play
#   nicely with resizes.
set -o noclobber
shopt -s histappend
HISTCONTROL=ignoreboth
shopt -s checkwinsize
shopt -s histverify


# EDITING FILES
#   I expect my editor to be vi (technically vim), and expect it to
#   run in tabbed mode when opening multiple files.
alias vi="vi -p"
export EDITOR=vi
export VISUAL=vi


# ENVIRONMENTAL STATUS FUNCTIONS
#   These will be used in the PS1 etc to give the current settings,
#   environment, etc.
if declare -F | grep -q __git_ps1
then
    : #(already included from /etc/bash_completion.d/git)
else
    function __git_ps1() {
        echo " (git?)"
    }
fi
function __nave_ps1() {
    if [ ! -z "$NAVENAME" ]
    then
        echo " (nave:$NAVENAME)"
    fi
}


# THE PROMPT {{{
#   The prompt is heavily influenced by the default Cygwin prompt.
#   I just feel it is nicer to spread out your commands and make
#   full use of your terminal's colours.  I apologise for this being
#   such a long config line!
launcher=""
[ -z $RANGER_LEVEL ] || launcher="\[\e[35m\](ranging) "
export PS1="\[\e]0;\w\a\]\n$launcher\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[34m\]$(__git_ps1 ' (%s)')\[\e[35m\]$(__nave_ps1)\[\e[0m\]\n\$ "
#}}}


# ALIASES
#   I know a lot of people separate aliases off into another file,
#   but as things stand I have so few of them that there seems very
#   little point in doing that.
alias gdiff="git diff"
alias gst="git status"
alias du0="du --max-depth=0"
alias du1="du --max-depth=1"
alias du2="du --max-depth=2"
alias du3="du --max-depth=3"


# CUSTOM SCRIPTS
#   If ~/bin/ exists it is given priority as a location for
#   executables.
if [ -d "$HOME/bin" ]
then
    export PATH="$HOME/bin:$PATH"
fi


# PRODUCTIVITY IMPROVEMENTS
#   To avoid the parts that are likely to hold me back.
alias sl="echo Boom! Train Crash!"
alias LS="echo Boom! Train Crash!"


# STANDARD TOOLKIT
#   Here I make the standard toolkit a bit friendlier for a
#   human user.  This includes using colour and nice file sizes.
#   I also override the standard colordiff wrapper with one that
#   works better for me.
export GREP_OPTIONS='--color=auto'
export LS_OPTIONS='-hF --color=tty'
alias ls='ls $LS_OPTIONS'
complete -f cdiff
function cdiff() { colordiff -u $@ | less -R; }


# LOCAL CONFIGURATION
#   If a config file exists containing machine specific config
#   then load it at this point.
[ -f "$HOME/.bashrc-local" ] && source "$HOME/.bashrc-local"


# CYGWIN SUPPORT
#   It is handy to be able to pull in a load of Cygwin specific things
#   when working in a Cygwin environment.
if [[ "$TERM" == "cygwin" ]]
then
    [ -f ~/.bashrc-cygwin ] && source ~/.bashrc-cygwin
fi

