#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

# Source predefined functions and variables
. /etc/profile

FLYCASTBIN="/usr/bin/flycastsa"

#set flycast BIOS dir to point to /storage/roms/bios/dc
if [ ! -L /storage/.local/share/flycast/data ]; then
	mkdir -p /storage/.local/share/flycast 
	rm -rf /storage/.local/share/flycast/data
	ln -s /storage/roms/bios/dc /storage/.local/share/flycast/data
fi

if [ ! -L /storage/.local/share/flycast/mappings ]; then
mkdir -p /storage/.local/share/flycast/
ln -sf /storage/.config/flycast/mappings /storage/.local/share/flycast/mappings
fi


# try to automatically set the gamepad in emu.cfg
y=1


for D in `find /dev/input/by-id/ | grep -e event-joystick -e amepad`; do
  str=$(ls -la $D)
  i=$((${#str}-1))
  DEVICE=$(echo "${str:$i:1}")
  CFG="/storage/.config/flycast/emu.cfg"
   sed -i -e "s/^evdev_device_id_$y =.*$/evdev_device_id_$y = $DEVICE/g" $CFG
 # echo "Device: $y input $DEVICE"
  y=$((y+1))
 if [$y -lt 4]; then
  break
 fi 
done

set_audio alsa

${FLYCASTBIN} "$1" &>/dev/null

 
