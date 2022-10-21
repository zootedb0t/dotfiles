from libqtile.config import Key, Group, Match
from libqtile.command import lazy
from .keys import keys, mod

# groups = [Group(i) for i in "123456789"]

# for i in groups:
#     keys.extend([
# mod1 + letter of group = switch to group
# Key([mod],
#     i.name,
#     lazy.group[i.name].toscreen(),
#     desc="Switch to group {}".format(i.name)),

# Key([mod], "Right", lazy.screen.next_group(),
#     desc="Switch to next group"),

# Key([mod], "Left", lazy.screen.prev_group(),
#     desc="Switch to previous group"),

# mod1 + shift + letter of group = switch to & move focused window to group
# Key([mod, "shift"],
#     i.name,
#     lazy.window.togroup(i.name, switch_group=True),
#     desc="Switch to & move focused window to group {}".format(i.name)),
# Or, use below if you prefer not to switch to that group.
# # mod1 + shift + letter of group = move focused window to group
# Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
#     desc="move focused window to group {}".format(i.name)),
# ])


groups = [
    Group("1", label=" ﲳ ", matches=[Match(wm_class="kitty")], layout="monadtall"),
    Group(
        "2",
        label="  ",
        matches=[Match(wm_class="firefox-nightly"), Match(wm_class="firefox")],
        layout="bsp",
    ),
    Group(
        "3",
        label="  ",
        matches=[
            Match(wm_class="Com.github.johnfactotum.Foliate"),
            Match(wm_class="Zathura"),
        ],
        layout="bsp",
    ),
    Group("4", label=" 四", layout="stack"),
    Group("5", label=" 五", layout="stack"),
    Group("6", label=" 六 ", layout="monadtall"),
    Group("7", label=" 七 ", layout="monadtall"),
    Group("8", label=" 八 ", layout="monadtall"),
    Group("9", label=" 九 ", layout="monadtall"),
]


for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # Key([mod], i.name, lazy.function(go_to_group(i.name))),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
            Key([mod], "Right", lazy.screen.next_group(), desc="Switch to next group"),
            Key(
                [mod], "Left", lazy.screen.prev_group(), desc="Switch to previous group"
            ),
        ]
    )
