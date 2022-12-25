#!/usr/bin/python3

import sys
from os import system
from os import WEXITSTATUS
from pathlib import Path
from shutil import which

from colorama import init

init(autoreset=True)

home = str(Path.home())
# TODO Fix for filename that has spaces
args = " ".join(sys.argv[1:])
if args.startswith("./"):
    args = args.replace("./","")
system("wal -i {}".format(args))

def pgrep(process):
    return (
        WEXITSTATUS(system("pgrep -c {} > /dev/null 2> /dev/null".format(process))) == 0
    )


if which("feh") is not None:
    f = open("/home/stoney/.cache/wal/wal", "r")
    wal_location = f.readline()
    system("feh --bg-center wal_location")

if which("xrdb") is not None:
    system("xrdb -merge ~/.Xresources")

# Reload various windowmanagers:
if pgrep("dwm"):
    system("xdotool key super+F5")

# if pgrep("st"):
#     system("pidof st | xargs kill -s USR1")
