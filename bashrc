

#======================================================================#
#                       BASH CONFIGURATION FILE                        #
#======================================================================#


# NON-INTERACTIVE GET-OUT
#   Only continue with these preferences in an interactive session.
#   Otherwise I shall stick to the defaults so that shell scripts
#   behave as the author expected.
#   It is possible to do this both by checking whether the prompt is set
#   and checking whether it's in interactive mode.
#[ -z "$PS1" ] && return
[[ $- != *i* ]] && return


# RELOAD LOCAL PATHS
#   When the session was started ~/.profile would have loaded in
#   the paths, but they are reloaded here just in case anything has
#   changed and I'm not in a position to log out/in.
if [ -f "$HOME/imemine/profile.paths" ]; then
    . "$HOME/imemine/profile.paths"
fi


# COMMAND COMPLETION WITH TAB
#   Most completion comes ready packaged:
source /usr/share/bash-completion/bash_completion
#   Though some needs specifying manually:
complete -F _command rlwrap
complete -F _command tsp
#   Stop the dodgy domains in /etc/hosts leaking in
HOSTFILE=


# PATH AND HISTORY COMPLETION WITH CTRL+T ETC
#   I guess fuzzy-finding is too invasive to be installed by default.
if [ -f "/usr/share/doc/fzf/examples/key-bindings.bash" ]; then
    . "/usr/share/doc/fzf/examples/key-bindings.bash"
fi


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
#   Allow double asterisk to match paths with slashes
shopt -s globstar


# EDITING FILES
#   I expect my editor to be vi, although really that should
#   be vim when it's available.  It should run in tabbed mode
#   when opening multiple files.
export EDITOR=vi
export VISUAL=vi
if [[ -e /usr/bin/vim ]]; then
    export EDITOR=vim
    export VISUAL=vim
    alias vi="vim -p"
fi


# PYTHON'S ENVIRONMENT AND PACKAGING
#   This is mostly to make the PS1 work better.
VIRTUAL_ENV_DISABLE_PROMPT="TRUE"
export PYTHONSTARTUP=$HOME/.pythonrc
if declare -F | grep -q virtualenvwrapper_load
then
    : Using virtualenvwrapper...
else
    : Custom completion...
    _workon_envs () {
        #ls "$HOME/.virtualenvs"
        ls ~/.virtualenvs/*/bin/activate | sed 's|.*virtualenvs/||' | sed 's|/.*||'
    }
    _workon () {
        halftyped="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=($(compgen -W "$(_workon_envs)" "$halftyped"))
    }
    workon() {
        source "$HOME/.virtualenvs/$1/bin/activate"
    }
    complete -F _workon workon
fi


# ENVIRONMENTAL STATUS FUNCTIONS
#   These will be used in the PS1 etc to give the current settings,
#   environment, etc.
#   Some people have an option to cat /etc/debian_chroot into their
#   prompt if they spend a lot of time using chroot.
[ -f /usr/lib/git-core/git-sh-prompt ] && source /usr/lib/git-core/git-sh-prompt
[ -f /usr/share/git/completion/git-prompt.sh ] && source /usr/share/git/completion/git-prompt.sh
# The extra sort below stops declare from moaning about broken pipes:
if declare -F | sort | grep -q __git_ps1
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
function __quilt_ps1() {
    # guard condtion, builtins only for speed.
    # messy, should also check parent dirs
    # and $QUILT_PC if it exists.
    [ ! -d .pc ] && return
    echo " ($(quilt top 2>&1))"
}
function __private_ps1() {
    if [ -z "$HISTFILE" ]
    then
        echo "(hush) "
    fi
}
function __incoming_ssh_ps1() {
    if [ ! -z "$SSH_TTY" ]
    then
        echo "<$HOSTNAME> "
    fi
}


# TITLING FUNCTIONS
#   For setting the title of terminal emulators.
function __set_title() {
    newtitle="$(__incoming_ssh_ps1)$(pwd)"
    case "$TERM" in
        xterm*) # including xterm-256color
            printf '\33]0;%s\007' "$newtitle"
            ;;
        rxvt-unicode*)
            printf '\33]2;%s\007' "$newtitle"
            ;;
        screen)
            echo -ne "\ek$newtitle\e\\"
            ;;
        *)
            ;;
    esac
}


# THE PROMPT
#   The prompt is heavily influenced by the default Cygwin prompt.
#   I just feel it is nicer to spread out your commands and make
#   full use of your terminal's colours.
launcher=""
[ -z $RANGER_LEVEL ] || launcher="\[\e[35m\](ranging) "
PS1=""
PS1="${PS1}\$(__set_title)\n"
PS1="${PS1}$(__incoming_ssh_ps1)"
PS1="${PS1}$launcher"
PS1="${PS1}\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[34m\]"
PS1="${PS1}\$(__git_ps1 ' (%s)')"
PS1="${PS1}\$(__quilt_ps1 ' (%s)')"
PS1="${PS1}\[\e[35m\]$(__nave_ps1)\$(__virtualenv_ps1)\$(__fakeroot_ps1)\[\e[0m\]"
PS1="${PS1}\n\\[\e[34;1m\]\$(__private_ps1)\[\e[0m\]$ "
export PS1


# PRINTING OPTIONS
#   Sending documents through `lp` is very convenient, but the
#   options that control it are not very handy.  Here I define
#   some abbreviations.
OOt=" -o page-top=36 -o page-bottom=36 -o page-left=36 "
OOs=" -o lpi=8 -o cpi=14 "
OO2=" -o number-up=2 "
OO4=" -o number-up=4 "
OOd=" -o sides=two-sided-long-edge "


# ALIASES
#   I know a lot of people separate aliases off into another file,
#   but as things stand I have so few of them that there seems very
#   little point in doing that.
alias gdiff="git diff"
alias gst="git status"
alias qgit="git -c user.name='Demo' -c user.email='demo@example.com'"
alias xgit="GNUPGHOME=/tmp/ git"
alias du0="du --max-depth=0"
alias du1="du --max-depth=1"
alias du2="du --max-depth=2"
alias du3="du --max-depth=3"
alias serveme="python3 -m http.server"
alias rr="ranger"
#alias open="xdg-open" #(replaced by `run` script)
alias foreach="xargs -n 1 -d \\\n -r"
alias xclip="xclip -selection clipboard"
alias id3="id3v2 -l"
alias w3m="w3m -title"
alias w3mt="w3m -title -T text/html"
alias ll="ls -l"
alias la="ls -A"
alias lt="ls -lt"
alias lS="ls -lhS"
#alias podget="wget --content-disposition"
# Can I replace midentify with ffprobe instead???
#alias midentify="mplayer -frames 0 -identify"
alias midentify="ffprobe -hide_banner"
alias macs="grep -i apple /usr/share/nmap/nmap-mac-prefixes | shuf | head"
#test -e /usr/share/doc/eyed3/examples/config.ini \
#    || alias eyeD3="eyeD3 --no-tagging-time-frame"
alias mkpasswd.md5="mkpasswd -m md5"
alias mkpasswd.256="mkpasswd -m sha-256"
alias mkpasswd.512="mkpasswd -m sha-512"
alias hush="unset HISTFILE"
alias ooops="unset HISTFILE"
alias xmodmap-right='xmodmap -e "keycode 135 = Right"'


# PRODUCTIVITY IMPROVEMENTS
#   To avoid the parts that are likely to hold me back.
alias sl="echo Boom! Train Crash!"
alias LS="echo Boom! Train Crash!"
alias l="echo Boom! Train Crash!"
alias :q="echo This is a shell!"
alias :wq="echo This is a shell!"


# STANDARD TOOLKIT
#   Here I make the standard toolkit a bit friendlier for a
#   human user.  This includes using colour and nice file sizes.
#   I also override the standard colordiff wrapper with one that
#   works better for me.
alias grep="grep --color=auto"
LS_OPTIONS='-hF --color=tty'
alias ls='ls $LS_OPTIONS'
complete -f cdiff
# Note that newer diffs have built-in colouring
function cdiff() { colordiff -u "$@" | less -R; }


# COLOURING IN LS
#   The dircolors program emits LS_COLORS="...", which enables
#   ls to highlight files, mostly based on extension.  I use the
#   defaults so I get any new entries from the maintainers,
#   but then I tweak the colouring of "other_writable" files
#   so that directory names on USB drives are actually readable!
eval "$(dircolors --bourne-shell <( \
    dircolors --print-database \
    | sed 's/34;42/01;04;34/g' \
    | sed 's/30;42/01;04;34;47/g' \
))"


# PACKAGING
#   The debian toolkit for building packages works much better if
#   you tell it who you are.  I used to simply export these envvars
#   but I disliked personal data being inherited by every process.
#   Unfortunately it doesn't work when the programs are called from
#   inside scripts and makefiles.
debdetails="DEBFULLNAME='P. S. Clarke' DEBEMAIL='debs@pscl4rke.net'"
alias dch="$debdetails dch"
alias dh_make="$debdetails dh_make"


# LOCAL CONFIGURATION
#   If a config file exists containing machine specific config
#   then load it at this point.  Things like the local printer.
[ -f "$HOME/.bashrc-local" ] && source "$HOME/.bashrc-local"


# WORK CONFIGURATION
#   If a config file exists containing lots of stuff for work then
#   load it here.
[ -f "$RVIMEMINE/bashrc-work" ] && source "$RVIMEMINE/bashrc-work"


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


# TRACK HISTORY AGE
#   As of Dec 2017 I am doing about 2-3k commands per month.
#echo "echo LAUNCHED AT $(date)" >> $HOME/.bash_history
