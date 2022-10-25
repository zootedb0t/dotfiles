from libqtile import bar
from .widgets import *
from libqtile.config import Screen
from modules.keys import terminal
import os


screens = [
    Screen(
        top=bar.Bar(
            [
                # widget.Sep(padding=3, linewidth=0, background="#2f343f"),
                #                widget.Image(filename='~/.config/qtile/eos-c.png', margin=3, background="#2f343f", mouse_callbacks={'Button1': lambda: qtile.cmd_spawn("rofi -show combi")}),
                # widget.Sep(padding=4, linewidth=0, background="#2f343f"),
                widget.GroupBox(
                    highlight_method="line",
                    this_screen_border="#69ff94",
                    this_current_screen_border="#69ff94",
                    active="#ffffff",
                    inactive="#848e96",
                    background="282a36",
                    urgent_alert_method="border",
                    urgent_border="#ff5555",
                ),
                widget.TextBox(text="", padding=0, fontsize=28, foreground="#282a36"),
                widget.Prompt(
                    foreground="#69ff94",
                    fontsize=15,
                    prompt=" : ",
                ),
                widget.Spacer(length=5),
                widget.WindowName(
                    foreground="#99c0de",
                    format="{state}{name}",
                    # fmt="{}"
                    fontsize=14,
                ),
                # widget.Chord(
                #     chords_colors={
                #         "launch": ("#ff0000", "#ffffff"),
                #     },
                #     name_transform=lambda name: name.upper(),
                # ),
                widget.CurrentLayoutIcon(scale=0.75),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=28,
                    foreground="#2f343f",
                ),
                widget.Spacer(
                    length=10,
                    background="#2f343f",
                ),
                widget.Net(
                    format=" {down}  {up}",
                    background="#2f343f",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                # widget.CPUGraph(
                #     type="box",
                #     border_width=3,
                #     # format='CPU {freq_current}GHz',
                #     background="#2f343f",
                # ),
                # widget.Spacer(
                #     length=5,
                #     background="#2f343f",
                # ),
                widget.CPU(
                    format="CPU {freq_current}GHz {load_percent}% ",
                    background="#2f343f",
                ),
                widget.ThermalZone(
                    zone="/sys/class/thermal/thermal_zone0/subsystem/thermal_zone9/temp",
                    format=" {temp}°C",
                    background="#2f343f",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                widget.Memory(
                    format="RAM {MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(terminal + " -e htop")
                    },
                    background="#2f343f",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                widget.NvidiaSensors(
                    threshold=55,
                    foreground_alert="ff6000",
                    format="GPU  {temp}°C",
                    background="#2f343f",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                widget.Backlight(
                    # change_command='xbacklight -get',
                    background="#2f343f",
                    backlight_name="nvidia_0",
                    brightness_file="actual_brightness",
                    format="  {percent:2.0%}",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                volume,
                widget.Volume(
                    get_volume_command="amixer -D pulse get Master".split(),
                    background="#2f343f",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                widget.CheckUpdates(
                    update_interval=1800,
                    distro="Arch_checkupdates",
                    fmt=" {}",
                    # no_update_string="No update",
                    foreground="#ffffff",
                    background="#2f343f",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            terminal + " -e sudo pacman -Syu"
                        )
                    },
                ),
                # widget.TextBox(text="", padding=0, fontsize=28, foreground="#2f343f"),
                # volume,
                # widget.TextBox(
                #     text="",
                #     padding=0,
                #     fontsize=28,
                #     foreground="#2f343f",
                # ),
                # widget.TextBox(text="", padding=0, fontsize=28, foreground="#2f343f"),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                widget.Clock(
                    format="  %d-%m-%Y %a   %I:%M %p",
                    background="#2f343f",
                    foreground="#9bd689",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn("gnome-clocks"),
                        "Button3": lambda: qtile.cmd_spawn("gnome-calendar"),
                    },
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
                widget.WidgetBox(
                    text_closed="  ",
                    text_open="  ",
                    background="#2f343f",
                    foreground="#ffffff",
                    widgets=[
                        widget.Wttr(
                            # TODO Can it switch location automatically
                            location={"Patna": "Home"},
                            format="%l: %c %t(%f) %C\n",
                            background="#2f343f",
                            foreground="#ffffff",
                        ),
                    ],
                ),
                widget.TextBox(
                    text="",
                    padding=0,
                    fontsize=28,
                    foreground="#2f343f",
                ),
                # widget.BatteryIcon(
                #     battery="BAT0",
                # ),
                # widget.Battery(
                #     battery="BAT0",
                #     format="{percent:2.0%}",
                #     update_interval=10,
                # ),
                battery,
                widget.Systray(
                    icon_size=25,
                    padding=3,
                    # background="#737373",
                ),
                widget.TextBox(
                    text="  ",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            os.path.expanduser("~/.config/rofi/powermenu.sh")
                        )
                    },
                    foreground="#e39378",
                ),
                widget.Spacer(
                    length=5,
                    background="#2f343f",
                ),
            ],
            30,  # height in px
            background="#404552",  # background color
        ),
    ),
]
