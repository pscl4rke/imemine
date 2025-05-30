#!/usr/bin/env sh


# This really wants documenting!


# It's been suggested that I could use GNU Stow for this
# instead, but it isn't as flexible.


ME="$0"
IMEMINE="$(dirname "$(realpath "$0")")"
VERBOSE=""


debug () {
    msg="$1"
    [ -z "$VERBOSE" ] && return
    echo "$ME [Debug] $msg" >&2
}

info () {
    msg="$1"
    echo "$ME [Info] $msg" >&2
}

warning () {
    msg="$1"
    echo "$ME [Warning] $msg" >&2
}

die () {
    msg="$1"
    echo "$ME [Fatal] $msg" >&2
    exit 1
}


_ensureparentdir () {
    fullpath="$1"
    parentpath="$(dirname "$fullpath")"
    if [ -d "$parentpath" ]
    then
        debug "Directory $parentpath already exists"
        return 0
    fi
    if mkdir -p "$parentpath"
    then
        info "Created directory $parentpath"
    else
        warning "Create of directory $parentpath failed"
    fi
}


_testparentdir () {
    fullpath="$1"
    parentpath="$(dirname "$fullpath")"
    if [ -d "$parentpath" ]
    then
        debug "Directory $parentpath already exists"
    else
        info "Would create directory at $parentpath"
    fi
}


installorsimulatelink () {
    srcrel="$1"
    destrel="$2"
    srcabs="$(cd "$IMEMINE" && realpath "$srcrel")"
    destabs="$HOME/$destrel"
    if [ -e "$destabs" ]
    then
        if [ -L "$destabs" ]
        then
            if [ "$(readlink "$destabs")" = "$srcabs" ]
            then
                debug "Symlink $destabs is already in place"
            else
                warning "A different symlink is a $destabs"
            fi
        else
            if [ "$MODE" = "clear" ]
            then
                renameto="$HOME/Desktop/cleared.$(basename "$destabs").$(date +%s)"
                warning "Moving $destabs to $renameto"
                mv "$destabs" "$renameto"
            else
                warning "Something already exists at $destabs"
            fi
        fi
    else
        case "$MODE" in
            install)
                _ensureparentdir "$destabs"
                if ln -s "$srcabs" "$destabs"
                then
                    info "Created symlink $destabs"
                else
                    warning "Creation of symlink $destabs failed"
                fi
                ;;
            simulate)
                _testparentdir "$destabs"
                info "Would create a symlink at $destabs"
                ;;
        esac
    fi
}


if [ "x$1" = "x-v" ]
then
    VERBOSE="set"
    shift
fi


MODE="$1"


case "$MODE" in
    install)
        wantlink () { installorsimulatelink "$@" ;}
        ;;
    simulate)
        wantlink () { installorsimulatelink "$@" ;}
        ;;
    clear)
        wantlink () { installorsimulatelink "$@" ;}
        ;;
    "")
        die "No subcommand given (install/simulate/clear)"
        ;;
    *)
        die "Unknown mode: $MODE (install/simulate/clear)"
        ;;
esac


wantlink "abcde.conf" ".abcde.conf"
wantlink "ackrc" ".ackrc"
wantlink "aspell.conf" ".aspell.conf"
wantlink "bashrc" ".bashrc"
wantlink "colordiffrc" ".colordiffrc"
wantlink "devscripts" ".devscripts"
wantlink "dillo" ".dillo"
wantlink "feh_keys" ".config/feh/keys"
wantlink "firefox/prefs.js" ".firefox.base.d/prefs.js"
wantlink "foot.ini" ".config/foot/foot.ini"
wantlink "gitconfig" ".gitconfig"
wantlink "hexerrc" ".hexerrc"
wantlink "hnbrc" ".hnbrc"
wantlink "html2psrc" ".html2psrc"
wantlink "imv_config" ".config/imv/config"
wantlink "linkbear_custom.ini" ".linkbear/custom.ini"
wantlink "linkbear_surfraw.ini" ".linkbear/surfraw.ini"
wantlink "lintianrc" ".lintianrc"
wantlink "lxde/config_pcmanfm_LXDE/" ".config/pcmanfm/LXDE"
wantlink "lxde/config_pcmanfm_LXDE/" ".config/pcmanfm/lubuntu"
wantlink "lxde/config_libfm_libfm.conf" ".config/libfm/libfm.conf"
wantlink "lxqt/config_lxqt_panel.conf" ".config/lxqt/panel.conf"
wantlink "lxqt/config_lxqt_notifications.conf" ".config/lxqt/notifications.conf"
wantlink "mailcap" ".mailcap"
wantlink "mpdefaults" ".mpdefaults"
wantlink "mplayer_config" ".mplayer/config"
wantlink "mpv.conf" ".mpv/mpv.conf"
wantlink "mpv.input.conf" ".mpv/input.conf"
wantlink "muttrc" ".muttrc"
wantlink "ncdu_config" ".config/ncdu/config"
wantlink "ncmpcpp_bindings" ".ncmpcpp/bindings"
wantlink "ncmpcpp_config" ".ncmpcpp/config"
wantlink "newsboat_config" ".newsboat/config"
wantlink "nvim/lua_myconf" ".config/nvim/lua/myconf"
wantlink "openbox/lxde-rc.xml" ".config/openbox/rc.xml"
wantlink "openbox/lxde-rc.xml" ".config/openbox/lxde-rc.xml"
wantlink "openbox/lxde-rc.xml" ".config/openbox/lubuntu-rc.xml"
wantlink "openbox/lxde-rc.xml" ".config/openbox/lxqt-rc.xml"
wantlink "profile" ".profile"
wantlink "pycodestyle" ".config/pycodestyle"
wantlink "pythonrc" ".pythonrc"
wantlink "rgignore" ".rgignore"
wantlink "screenrc" ".screenrc"
wantlink "shellcheckrcxxx" ".shellcheckrc"
wantlink "term.light.env" ".term.env"
wantlink "tigrc" ".tigrc"
wantlink "tilda" ".config/tilda/config_0"
wantlink "urlview" ".urlview"
wantlink "vimrc" ".vimrc"
wantlink "vim/dirMakefile" ".vim/Makefile"
wantlink "vim/colors_printmono.vim" ".vim/colors/printmono.vim"
wantlink "vim/syntax_dockerenv.vim" ".vim/syntax/dockerenv.vim"
wantlink "vim/syntax_known_hosts.vim" ".vim/syntax/known_hosts.vim"
wantlink "w3m_config" ".w3m/config"
wantlink "w3m_keymap" ".w3m/keymap"
wantlink "wyrdrc" ".wyrdrc"
wantlink "Xdefaults" ".Xdefaults"
wantlink "xdg-apps" ".local/share/applications/imemine"
wantlink "xmodmap.extra" ".xmodmap.extra"
wantlink "yt-dlp" ".config/yt-dlp/config"
wantlink "zathurarc" ".config/zathura/zathurarc"

# Read by LXDE's lxsession (and openbox-session), but ignored in LXQt...
#   https://github.com/lxde/lxsession
#   https://github.com/lxqt/lxqt-session
#wantlink "openbox/autostart" ".config/openbox/autostart"
#wantlink "openbox/autostart" ".config/openbox/autostart.sh"
#wantlink "openbox/autostart" ".config/lxsession/LXDE/autostart"
#wantlink "openbox/autostart" ".config/lxsession/Lubuntu/autostart"
#wantlink "openbox/autostart" ".config/lxsession/LXQt/autostart"

wantlink "xdg-autostart/on-login-gui.desktop" ".config/autostart/on-login-gui.desktop"
# Hidden things won't start...
wantlink "xdg-autostart/geoclue-demo-agent.desktop" ".config/autostart/geoclue-demo-agent.desktop"

# Recent versions of ack-grep don't need this, because they
# have both /usr/bin/ack-grep and /usr/bin/ack...
#wantlink "/usr/bin/ack-grep" "bin/ack"

# Stop thumbnail caching...
wantlink "/tmp" ".cache/sxiv"
wantlink "/tmp" ".cache/nsxiv"

wantlink "vendor/urxvt_perl_vtwheel" ".urxvt/perl/vtwheel"
wantlink "vendor/urxvt_perl_resize-font" ".urxvt/perl/resize-font"
# Do I really want this vim_addons thing????
wantlink "/usr/share/vim/addons/syntax" ".vim_addons/syntax"

wantlink "vendor/vcal.pl" "bin/vcal"

# Block unless explicit --datadir is given
wantlink "/dev/null" ".local/share/shotwell"
