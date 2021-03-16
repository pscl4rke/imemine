

# Use "gsettings list-recursively" to get an overview of all this


# Defaults to ~/Pictures...
#   might not work :(
gsettings set org.gnome.gnome-screenshot auto-save-directory 'file:///home/$USER/Downloads'


# maybe this will help
#    https://blog.shadura.me/2018/02/23/gnome-settings-daemon-keyboard-layouts/
gsettings set org.gnome.settings-daemon.plugins.keyboard active false


# minimise and screenlock default to Win-h and Win-l
# disable so that Win-h/j/k/l muscle memory isn't a nuisance
gsettings set org.gnome.desktop.wm.keybindings minimize "[]"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "[]"


#$ dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
#[/]
#binding='<Primary><Alt>space'
#command='/usr/bin/launchbear'
#name='Launchbear Menu'


# file browser
gsettings set org.gnome.settings-daemon.plugins.media-keys home "['<Super>x']"


# lock screen woes
gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action "'nothing'"
gsettings set org.gnome.desktop.screensaver lock-enabled "false"


# volume
# doesn't work :(
#gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute-static "['XF86AudioMute', '<Ctrl><Alt>0']"
#gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['<Primary><Alt>minus']"
#org.gnome.settings-daemon.plugins.media-keys volume-up ['<Primary><Alt>equal']
#org.gnome.settings-daemon.plugins.media-keys volume-mute-static ['<Ctrl><Alt>0']


# affects ctrl+alt+T, but not file browser :(
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ''
gsettings set org.gnome.desktop.default-applications.terminal exec "'/home/psc/imemine/bin/open-in-terminal'"


# disk space popup
gsettings set org.gnome.settings-daemon.plugins.housekeeping active false


# i don't like dash-to-dock very much!
#gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces "true"
#gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites "false"
#gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts "false"


# use dash-to-panel instead of the default dash-to-dock!
#  WAS org.gnome.shell enabled-extensions @as []
#  NOW org.gnome.shell enabled-extensions ['dash-to-panel@jderose9.github.com']
gsettings set org.gnome.shell.extensions.dash-to-panel group-apps "false"
gsettings set org.gnome.shell.extensions.dash-to-panel show-favorites "false"
gsettings set org.gnome.shell.extensions.dash-to-panel group-apps-underline-unfocused "false"
gsettings set org.gnome.shell.extensions.dash-to-panel panel-size "32"
gsettings set org.gnome.shell.extensions.dash-to-panel appicon-margin "0"
gsettings set org.gnome.shell.extensions.dash-to-panel isolate-workspaces "true"


# horizonal workspaces
#  NOW org.gnome.shell enabled-extensions ['dash-to-panel@jderose9.github.com', 'horizontal-workspaces@gnome-shell-extensions.gcampax.github.com', 'workspace-indicator@gnome-shell-extensions.gcampax.github.com']
# ctrl-alt is the default, but we can have multiple:
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left "['<Control><Alt>Left', '<Super>Comma']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right "['<Control><Alt>Right', '<Super>Period']"


# udisks has poor defaults
gsettings set org.gnome.desktop.media-handling automount "false"

