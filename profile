

#======================================================================#
#                      PROFILE CONFIGURATION FILE                      #
#======================================================================#


# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1) if ~/.bash_profile or ~/.bash_login
# exists.

# This file is sourced when a "session" starts.  That includes logging
# into a virtual terminal, logging in via SSH, and logging into an X
# session with graphics.

# However it is NOT sourced each time a shell like bash is started.
# Something like ~/.bashrc should be used for that instead.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# load various environment variables, that are worked out on a
# machine-to-machine basis
if [ -f "$HOME/imemine/profile.paths" ]; then
    . "$HOME/imemine/profile.paths"
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

