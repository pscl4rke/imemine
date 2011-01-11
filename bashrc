

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


# BASIC OPTIONS
#   I ask bash not to overwrite an existing file using the
#   redirects and to be nice with the history file.  Also play
#   nicely with resizes.
set -o noclobber
shopt -s histappend
HISTCONTROL=ignoreboth
shopt -s checkwinsize


# EDITING FILES
#   I expect my editor to be vi (technically vim), and expect it to
#   run in tabbed mode when opening multiple files.
alias vi="vi -p"
export EDITOR=vi
export VISUAL=vi


# GIT AUTOCOMPLETE ETC
#   Currently, Git completion is carried out by Shawn O Pearce's
#   script, but I'm willing to change that if there are other ones
#   out there (esp. faster ones).  I create a dummy PS1 function
#   for if the script cannot be found.
#   The script is semi-official, and copies can be found in the
#   Git source under contrib/completion.
function __git_ps1() {
    echo
}
if [ -f ~/.git-completion.sh ]
then
    source ~/.git-completion.sh
fi


# THE PROMPT
#   The prompt is heavily influenced by the default Cygwin prompt.
#   I just feel it is nicer to spread out your commands and make
#   full use of your terminal's colours.  I apologise for this being
#   such a long config line!
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[34m\]$(__git_ps1 " (%s)")\[\e[0m\]\n\$ '


# ALIASES
#   I know a lot of people separate aliases off into another file,
#   but as things stand I have so few of them that there seems very
#   little point in doing that.
alias gdiff="git diff"
alias gst="git status"


# STANDARD TOOLKIT
#   Here I make the standard toolkit a bit friendlier for a
#   human user.  This includes using colour and nice file sizes.
export GREP_OPTIONS='--color=auto'
export LS_OPTIONS='-hF --color=tty'
alias ls='ls $LS_OPTIONS'


# LOCAL CONFIGURATION
#   If a config file exists containing machine specific config
#   then load it at this point.
[ -f "~/.bashrc-local" ] && source "~/.bashrc-local"


# CYGWIN SUPPORT
#   It is handy to be able to pull in a load of Cygwin specific things
#   when working in a Cygwin environment.
if [[ "$TERM" == "cygwin" ]]
then
    [ -f ~/.bashrc-cygwin ] && source ~/.bashrc-cygwin
fi

