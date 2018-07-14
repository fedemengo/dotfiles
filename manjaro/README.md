# Manjaro on Lenovo-X1-Carbon

- Copy `grub` to `/etc/default/grub`
- Copy `i3-config` to `~/.i3/config`
- Copy `Xresources` to `~/.Xresources/`
    - `xrdb ~/.Xresources`
- Install **Oh-My-Zsh**

### Touchscreen

- Install **touchegg**
	- Copy `touchegg.conf` to `~/.config/touchegg/`
- Create `~/.xprofile` and add `touchegg &`
- Add the following line to `~/.xinitrc`
	- `[ -f ~/.xprofile ] &&  . ~/.xprofile`

### Touchpad

- Install **libinput**
	- Copy `40-libinput.conf` to `/etc/X11/xorg.conf.d/`


## Configuration files

### 40-libinput.conf

```
Section "InputClass"
        Identifier "libinput touchpad catchall"
        MatchIsTouchpad "on"
        MatchDevicePath "/dev/input/event*"
        Driver "libinput"
	Option "NaturalScrollin" "false"
	Option "AccelSpeed" "0.7"
	Option "AccelProfile" "adaptive"
	Option "Tapping" "true"
	Option "TappingButtonMap" "lrm"
EndSection
```

### touchegg.conf

```
<touchégg>
  <settings>
    <property name="composed_gestures_time">111</property>
  </settings>
  <application name="All">
    <gesture type="DRAG" fingers="1" direction="ALL">
      <action type="DRAG_AND_DROP">BUTTON=1</action>
    </gesture>
    <gesture type="DRAG" fingers="3" direction="UP">
      <action type="MAXIMIZE_RESTORE_WINDOW"></action>
    </gesture>
    <gesture type="DRAG" fingers="3" direction="DOWN">
      <action type="MINIMIZE_WINDOW"></action>
    </gesture>
    <gesture type="DRAG" fingers="2" direction="ALL">
      <action type="SCROLL">SPEED=7:INVERTED=true</action>
    </gesture>
    <gesture type="PINCH" fingers="2" direction="IN">
      <action type="SEND_KEYS">Control+minus</action>
    </gesture>
    <gesture type="PINCH" fingers="2" direction="OUT">
      <action type="SEND_KEYS">Control+plus</action>
    </gesture>
    <gesture type="TAP" fingers="3" direction="">
      <action type="MOUSE_CLICK">BUTTON=2</action>
    </gesture>
    <gesture type="TAP" fingers="2" direction="">
      <action type="MOUSE_CLICK">BUTTON=3</action>
    </gesture>
    <gesture type="TAP" fingers="1" direction="">
      <action type="MOUSE_CLICK">BUTTON=1</action>
    </gesture>
  </application>
</touchégg>
```


