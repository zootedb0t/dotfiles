from libqtile import layout
from libqtile.config import Match

# DEFAULT THEME SETTINGS FOR LAYOUTS #
layout_theme = {
    "border_width": 2,
    "margin": 10,
    "border_focus": "#6272a4",
    "border_normal": "#282a36",
}

layouts = [
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    layout.Matrix(**layout_theme),
    layout.MonadWide(**layout_theme),
    # layout.RatioTile(margin=8, border_focus='#5294e2'),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(**layout_theme),
    layout.MonadTall(**layout_theme, single_border_width=0),
    layout.Stack(num_stacks=2, **layout_theme),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    layout.Bsp(**layout_theme),
    layout.Columns(**layout_theme),
]

floating_layout = layout.Floating(
        border_focus="#6272a4",
        border_normal="#282a36",
        border_width=3,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="Places"),  # Firefox bookmark menu
        Match(wm_class="Browser"),  # Firefox about menu
        Match(wm_class="Blueberry.py"),
        Match(wm_class="Toolkit"),
        Match(wm_class="Pavucontrol"),
        Match(wm_class="Protonvpn"),
    ]
)
