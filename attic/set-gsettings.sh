
# Defaults to ~/Pictures...
#   might not work :(
gsettings set org.gnome.gnome-screenshot auto-save-directory 'file:///home/$USER/Downloads'

gsettings get org.gnome.settings-daemon.plugins.media-keys screensaver
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "[]"
gsettings get org.gnome.settings-daemon.plugins.media-keys screensaver
#gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver "['<Super>l']"
#gsettings get org.gnome.settings-daemon.plugins.media-keys screensaver


gsettings set org.gnome.desktop.wm.keybindings minimize "[]"


#$ dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
#[/]
#binding='<Primary><Alt>space'
#command='/usr/bin/launchbear'
#name='Launchbear Menu'



# use dash-to-panel instead of the default dash-to-dock!
#gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces "true"
#gsettings set org.gnome.shell.extensions.dash-to-dock show-favorites "false"
#gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts "false"
