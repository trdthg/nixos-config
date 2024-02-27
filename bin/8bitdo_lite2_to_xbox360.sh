xboxdrv \
  --evdev /dev/input/event15 \
  --evdev-absmap ABS_X=x1,ABS_Y=y1,ABS_Z=x2,ABS_RZ=y2,ABS_HAT0X=dpad_x,ABS_HAT0Y=dpad_y \
  --axismap -Y1=Y1,-Y2=Y2 \
  --mimic-xpad --evdev-debug \
  --evdev-keymap BTN_A=a,BTN_B=b,BTN_X=x,BTN_Y=y,BTN_TR=rb,BTN_TR2=rt,BTN_TL=lb,BTN_TL2=lt,BTN_START=start,BTN_SELECT=back,BTN_THUMBL=tl,BTN_THUMBR=tr,BTN_MODE=guide

# left: to which name
# right: key
