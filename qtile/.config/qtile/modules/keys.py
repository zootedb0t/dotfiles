from libqtile.lazy import lazy
from libqtile.config import Key

mod = "mod4"
terminal = "alacritty"
browser = "firefox-nightly"

# Fixing floating window

@lazy.function
def float_to_front(qtile):
    # logging.info("bring floating windows to front")
    for group in qtile.groups:
        for window in group.windows:
            if window.floating:
                window.cmd_bring_to_front()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod], "r", lazy.spawn("rofi -show combi"), desc="spawn rofi"),
    Key([mod, "shift"], "d", lazy.spawn("rofi -show drun"), desc="spawn rofi app menu"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Make window full screen.
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle floating",
    ),

    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_floating(),
    ),

    Key(
        [mod, "control"],
        "f",
        # lazy.window.toggle_floating(),
        float_to_front,
        desc="Toggle fullscreen",
    ),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "w", lazy.spawn(browser), desc="Launch Browser"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift", "control"], "h", lazy.layout.swap_column_left()),
    Key([mod, "shift", "control"], "l", lazy.layout.swap_column_right()),
    Key([mod, "shift"], "space", lazy.layout.flip()),
    Key([mod, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key(
        [mod, "shift"],
        "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget",
    ),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer set Master 3%+")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer set Master 3%-")),
    Key([], "XF86AudioMute", lazy.spawn("amixer set Master toggle")),

    # Toggle bars
    Key([mod], "b", lazy.hide_show_bar(position="all"), desc="Toggle bars"),

    # Brightness control using keyboard
    # Key([],"XF86MonBrightnessUp", lazy.spawn("xbacklight -inc 10")),
    # Key([],"XF86MonBrightnessDown", lazy.spawn("xbacklight -dec 10")),
    
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("bash /home/stoney/.local/bin/brightnessControl.sh up"),
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("bash /home/stoney/.local/bin/brightnessControl.sh down"),
    ),

    # Screenshot
    # Key([], "Print", lazy.spawn("scrot '%Y-%m-%d-%H-%M-%S-screenshot.png' -e 'mv $f ~/Pictures/screenshots/'"), desc="Take Screenshot"),
    Key(
        [],
        "Print",
        lazy.spawn("bash /home/stoney/.local/bin/screenshot.sh normal"),
        desc="Take Screenshot",
    ),
    Key(
        ["shift"],
        "Print",
        lazy.spawn("bash /home/stoney/.local/bin/screenshot.sh region"),
        desc="Take region Screenshot",
    ),

    # Lockscreen
    Key([mod], "s", lazy.spawn("betterlockscreen -l dim"), desc="Lockscreen"),
]
