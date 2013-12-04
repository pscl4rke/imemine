#!/usr/bin/env sh


# This really wants documenting!


ME="$0"


IMEMINE="$HOME/imemine"


debug () {
    msg="$1"
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


installorsimulatelink () {
    srcrel="$1"
    destrel="$2"
    if [ -e "$HOME/$destrel" ]
    then
        if [ -L "$HOME/$destrel" ]
        then
            if [ "$(readlink "$HOME/$destrel")" = "$IMEMINE/$srcrel" ]
            then
                debug "Symlink $HOME/$destrel is already in place"
            else
                warning "A different symlink is a $HOME/$destrel"
            fi
        else
            warning "Something already exists at $HOME/$destrel"
        fi
    else
        case "$MODE" in
            install)
                _ensureparentdir "$HOME/$destrel"
                if ln -s "$IMEMINE/$srcrel" "$HOME/$destrel"
                then
                    info "Created symlink $HOME/$destrel"
                else
                    warning "Creation of symlink $HOME/$destrel failed"
                fi
                ;;
            simulate)
                info "Would create a symlink at $HOME/$destrel"
                ;;
        esac
    fi
}


MODE="$1"
[ -z "$MODE" ] && die "No subcommand given"


case "$MODE" in
    install)
        #wantlink () { installlink "$@" ;}
        wantlink () { installorsimulatelink "$@" ;}
        ;;
    simulate)
        #wantlink () { simulatelink "$@" ;}
        wantlink () { installorsimulatelink "$@" ;}
        ;;
    *)
        die "Unknown mode: $MODE"
        ;;
esac


wantlink "abcde.conf" ".abcde.conf"
wantlink "ackrc" ".ackrc"
wantlink "bashrc" ".bashrc"
wantlink "colordiffrc" ".colordiffrc"
wantlink "gitconfig" ".gitconfig"
wantlink "mplayer_config" ".mplayer/config"
wantlink "openbox/lxde-rc.xml" ".config/openbox/lxde-rc.xml"
wantlink "openbox/lxde-rc.xml" ".config/openbox/lubuntu-rc.xml"
wantlink "pythonrc" ".pythonrc"
wantlink "screenrc" ".screenrc"
wantlink "tigrc" ".tigrc"
wantlink "vimrc" ".vimrc"
wantlink "w3m_config" ".w3m/config"
wantlink "Xdefaults" ".Xdefaults"

wantlink "vendor/urxvt_perl_vtwheel" ".urxvt/perl/vtwheel"

