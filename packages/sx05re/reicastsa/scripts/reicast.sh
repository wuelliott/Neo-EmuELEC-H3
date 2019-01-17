#!/bin/sh

#set reicast BIOS dir to point to /storage/roms/bios
if [ ! -L /storage/.local/share/reicast/data ]; then
	mkdir -p /storage/.local/share/reicast 
	rm -rf /storage/.local/share/reicast/data
	ln -s /storage/roms/bios/dc /storage/.local/share/reicast/data
fi

if [ ! -d /storage/.local/share/reicast/mappings ]; then
mkdir -p /storage/.local/share/reicast/mappings
cp -r /storage/.config/reicast/mappings/* /storage/.local/share/reicast/mappings
fi


# try to automatically set the gamepad in emu.cfg
y=1


for D in `find /dev/input/by-id/ | grep event-joystick`; do
  str=$(ls -la $D)
  i=$((${#str}-1))
  DEVICE=$(echo "${str:$i:1}")
  CFG="/storage/.config/reicast/emu.cfg"
   sed -i -e "s/^evdev_device_id_$y =.*$/evdev_device_id_$y = $DEVICE/g" $CFG
 # echo "Device: $y input $DEVICE"
  y=$((y+1))
 if [$y -lt 4]; then
  break
 fi 
done

/usr/bin/reicast "$1"

 
