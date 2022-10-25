from libqtile import hook
import subprocess
import os

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])
    subprocess.Popen('/usr/bin/nm-applet')
#    subprocess.Popen('/usr/bin/light-locker')
    # subprocess.Popen('/usr/bin/xfce4-power-manager')
