

#======================================================================#
#                       BASH CONFIGURATION FILE                        #
#======================================================================#


# NON-INTERACTIVE GET-OUT
#   Only continue with these preferences in an interactive session.
#   Otherwise I shall stick to the defaults so that shell scripts
#   behave as the author expected.
#   Note that I check whether the prompt is set here, but it is also
#   possible to test whether "i" appears in "$-" using something
#   like a case statement.
[ -z "$PS1" ] && return


# BORROWED FROM UBUNTU DEFAULTS
#   I don't know how much these are needed, but I include them in
#   case it reduces the usability that I've been accustomed to.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


# COMMAND COMPLETION
#   Eventually I will drop the echo statements, but I'm still
#   concerned that the completion routines take too long.
echo -n "Setting up completion... "
source /usr/share/bash-completion/bash_completion
echo "Done."


# EXPLICITLY DECLARE BASIC OPTIONS
#   Don't overwrite an existing file using redirects:
set -o noclobber
#   Add history to file, but don't replace existing lines:
shopt -s histappend
#   Expand out things like !! and !:1 but don't immediately run:
shopt -s histverify
#   Don't add repeated commands or space-preceded ones to history:
HISTCONTROL=ignoreboth
#   Keep *loads* of history:
HISTSIZE=5000
HISTFILESIZE=5000
#   Update $LINES and $COLUMNS after commands:
shopt -s checkwinsize
#   Ensure that the $PS1 gets properly evaluated:
shopt -s promptvars


# EDITING FILES
#   I expect my editor to be vi (technically vim), and expect it to
#   run in tabbed mode when opening multiple files.
alias vi="vi -p"
export EDITOR=vi
export VISUAL=vi


# PYTHON'S ENVIRONMENT AND PACKAGING
#   This is mostly to make the PS1 work better, and to handle
#   offline environments.
VIRTUAL_ENV_DISABLE_PROMPT="TRUE"
alias pip-install-from-basket="pip install --no-index -f file://$HOME/.basket"
export PYTHONSTARTUP=$HOME/.pythonrc
#function workon() {
#    echo Just sourcing...
#    source /etc/bash_completion.d/virtualenvwrapper
#    echo Please try that again
#}


# ENVIRONMENTAL STATUS FUNCTIONS
#   These will be used in the PS1 etc to give the current settings,
#   environment, etc.
#   Some people have an option to cat /etc/debian_chroot into their
#   prompt if they spend a lot of time using chroot.
[ -f /usr/lib/git-core/git-sh-prompt ] && source /usr/lib/git-core/git-sh-prompt
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
function __virtualenv_ps1() {
    if [ ! -z "$VIRTUAL_ENV" ]
    then
        echo " (venv:$(basename "$VIRTUAL_ENV"))"
        #echo " (venv:$VIRTUAL_ENV)"
    fi
}
function __fakeroot_ps1() {
    if [ ! -z "$FAKED_MODE" ]
    then
        echo " (fake:$FAKED_MODE)"
    fi
}


# TITLING FUNCTIONS
#   For setting the title of terminal emulators.
function __set_title() {
    newtitle="$(pwd)"
    case "$TERM" in
        rxvt-unicode)
            printf '\33]2;%s\007' "$newtitle"
            ;;
        screen)
            echo -ne "\ek$newtitle\e\\"
            ;;
        *)
            ;;
    esac
}


# THE PROMPT {{{
#   The prompt is heavily influenced by the default Cygwin prompt.
#   I just feel it is nicer to spread out your commands and make
#   full use of your terminal's colours.  I apologise for this being
#   such a long config line!
launcher=""
[ -z $RANGER_LEVEL ] || launcher="\[\e[35m\](ranging) "
export PS1="\$(__set_title)\n$launcher\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[34m\]\$(__git_ps1 ' (%s)')\[\e[35m\]$(__nave_ps1)\$(__virtualenv_ps1)\$(__fakeroot_ps1)\[\e[0m\]\n\$ "
#}}}


# ALIASES
#   I know a lot of people separate aliases off into another file,
#   but as things stand I have so few of them that there seems very
#   little point in doing that.
alias gdiff="git diff"
alias gst="git status"
alias qgit="git -c user.name='Demo' -c user.email='demo@example.com'"
alias du0="du --max-depth=0"
alias du1="du --max-depth=1"
alias du2="du --max-depth=2"
alias du3="du --max-depth=3"
alias serveme="python -m SimpleHTTPServer"
alias rr="ranger"
#alias open="xdg-open" #(replaced by `run` script)
alias foreach="xargs -n 1 -d \\\n -r"
alias xclip="xclip -selection clipboard"
alias id3="id3v2 -l"
alias w3mt="w3m -T text/html"
alias ll="ls -l"
alias la="ls -A"


# CUSTOM SCRIPTS
#   If ~/bin/ exists it is added as a location for
#   executables.  Also make use of imemine if it is there.
#   However none of them should take priority over system
#   paths.
[ -d "$HOME/imemine/bin" ] && export PATH="$PATH:$HOME/imemine/bin"
[ -d "$HOME/bin" ] && export PATH="$PATH:$HOME/bin"


# PRODUCTIVITY IMPROVEMENTS
#   To avoid the parts that are likely to hold me back.
alias sl="echo Boom! Train Crash!"
alias LS="echo Boom! Train Crash!"
alias :q="echo This is a shell!"
alias :wq="echo This is a shell!"


# STANDARD TOOLKIT
#   Here I make the standard toolkit a bit friendlier for a
#   human user.  This includes using colour and nice file sizes.
#   I also override the standard colordiff wrapper with one that
#   works better for me.
export GREP_OPTIONS='--color=auto'
export LS_OPTIONS='-hF --color=tty'
alias ls='ls $LS_OPTIONS'
complete -f cdiff
function cdiff() { colordiff -u "$@" | less -R; }


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

# SHOW A FORTUNE {{{
#   The last thing to do is to take the newly prepared shell and shove
#   a pretty little fortune at the top.  Note it doesn't use the system
#   fortune program, because I find it suboptimal.
#   See https://github.com/pscl4rke/fortune2
if [ -e "$HOME/bin/fortune" ]
then
    echo
    $HOME/bin/fortune
    echo
fi
#}}}


