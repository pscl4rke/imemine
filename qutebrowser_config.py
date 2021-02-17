
import sys
python_executable = sys.prefix + "/bin/python"
#python_executable = sys.executable

import os
imemine = os.path.dirname(__file__)

c.tabs.background = True

#config.bind("r", "spawn --userscript /home/psc/imemine/vendor/qutebrowser_readability")
#config.bind("r", "spawn --userscript /home/psc/.virtualenvs/qutebrowser/bin/python /home/psc/imemine/vendor/qutebrowser_readability")
config.bind("r", "spawn --userscript %s %s" % (
    python_executable, os.path.join(imemine, "vendor/qutebrowser_readability")))
