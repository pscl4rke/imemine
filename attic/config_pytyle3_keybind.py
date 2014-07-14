# This is a python script. Pay attention to the syntax and indentation
import state
import tile

bindings = {
# You can use Control and Shift. Alt is Mod1, Super is Mod4.

#Available commands :
# tile: start tiling
# untile: stop tiling and move the windows back to their original position
# cycle: switch between horizontal and vertical tiling

# increase_master: increase the space allocated to master windows
# decrease_master: increase the space allocated to slave windows
# add_master: send a window from the slave group to the master group
# remove_master: send a window from the master group to the slave group

# prev_client: Focus the previous window
# next_client: Focus the next window
# focus_master: Focus the master window

# switch_prev_client: switch active window with previous
# switch_next_client: switch active window with next
# rotate: shift all windows' positions (clockwise)
# make_master: send active window to the master position

	'Control-Mod4-v': tile.cmd('tile'),
    'Control-Mod4-BackSpace': tile.cmd('untile'),
    'Control-Mod4-s': tile.cmd('decrease_master'),
    'Control-Mod4-r': tile.cmd('increase_master'),
    'Control-Mod4-g': tile.cmd('remove_master'),
    'Control-Mod4-d': tile.cmd('add_master'),
	'Control-Mod4-c': tile.cmd('rotate'),
    'Control-Mod4-h': tile.cmd('cycle'),
    'Control-Mod4-f': tile.cmd('toggle_float'),
    'Control-Mod4-m': tile.cmd('make_master'),

# quit pytyle
    'Control-Mod4-q': state.quit,
}

