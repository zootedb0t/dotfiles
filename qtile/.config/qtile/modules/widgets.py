from libqtile import widget
from libqtile import qtile
from libqtile.widget.battery import Battery, BatteryState

colors = [
    ["#2f343f", "#2f343f"],  # panel background
    ["#3d3f4b", "#434758"],  # background for current screen tab
    ["#ffffff", "#ffffff"],  # font color for group names
    ["#ff5555", "#ff5555"],  # border line color for current tab
    [
        "#74438f",
        "#74438f",
    ],  # border line color for 'other tabs' and color for 'odd widgets'
    ["#4f76c7", "#4f76c7"],  # color for the 'even widgets'
    ["#e1acff", "#e1acff"],  # window name
    ["#ecbbfb", "#ecbbfb"],  # backbround for inactive screens
]

##################
# VOLUME WIDGET  #
##################

class MyVolume(widget.Volume):
    def _configure(self, qtile, bar):
        widget.Volume._configure(self, qtile, bar)
        self.volume = self.get_volume()
        if self.volume <= 0:
            self.text = '婢 '
        elif self.volume <= 33:
            self.text = ' '
        elif self.volume < 66:
            self.text = '墳 '
        else:
            self.text = ' '

    def _update_drawer(self, wob=False):
        if self.volume <= 0:
            self.text = '婢 '
        elif self.volume <= 33:
            self.text = ' '
        elif self.volume < 66:
            self.text = '墳 '
        else:
            self.text = ' '
        self.draw()

        if wob:
            with open(self.wob, 'a') as f:
                 f.write(str(self.volume) + "\n")

volume = MyVolume(
    foreground=colors[2],
    background=colors[0],
    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn("pavucontrol")}
)

##################
# BATTERY WIDGET #
##################

class MyBattery(Battery):
    def build_string(self, status):
        if self.layout is not None:
            if status.state == BatteryState.DISCHARGING and status.percent < self.low_percentage:
                self.layout.colour = self.low_foreground
            else:
                self.layout.colour = self.foreground
        if status.state == BatteryState.DISCHARGING:
            if status.percent >= 0.90:
                char = ''
            elif status.percent >= 0.80:
                char = ''
            elif status.percent >= 0.70:
                char = ''
            elif status.percent >= 0.60:
                char = ''
            elif status.percent >= 0.50:
                char = ''
            elif status.percent >= 0.40:
                char = ''
            elif status.percent >= 0.30:
                char = ''
            elif status.percent >= 0.20:
                char = ''
            elif status.percent >= 0.10:
                char = ''
            else:
                char = ''
        elif status.percent >= 1 or status.state == BatteryState.FULL:
            char = '' #HERE YOU CAN PUT WHATEBER YOU WANT
        elif status.state == BatteryState.EMPTY or \
                (status.state == BatteryState.UNKNOWN and status.percent == 0):
            char = ''
        else:
            char = ' '
        return self.format.format(char=char, percent=status.percent)


battery = MyBattery(
    format='{percent:2.0%} {char} ',
    low_foreground=colors[5],
    show_short_text=False,
    low_percentage=0.25,
    fontsize=15,
    update_interval=15,
    # font="JetBrainMonoExtraBold Nerd Font",
    # background=colors[0],
    foreground="#14c43a"
)
