#!/bin/sh

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

# Read the video output mode and set it for emuelec to avoid video flicking.

EE_DEVICE=$(cat /ee_arch)
if [ "$EE_DEVICE" == "H3" ]; then
		exit 1
fi


#MODE=`cat /sys/class/display/mode`;
MODE=`/usr/bin/cat /emuelec/configs/emuelec.conf | /usr/bin/grep ee_videomode |  /usr/bin/awk -F"=" '{ print $2 }'`;
BPP=32

if [ -e /ee_s905 ]; then
case "$MODE" in
"480p60hz")
	fbset -fb /dev/fb0 -g 720 480 720 960 $BPP
	;;
"576p50hz")
	fbset -fb /dev/fb0 -g 720 576 720 1152 $BPP
	;;
"720p60hz")
	fbset -fb /dev/fb0 -g 1280 720 1280 1440 $BPP
	;;
"720p50hz")
	echo 720p60 > /sys/class/display/mode
	fbset -fb /dev/fb0 -g 1280 720 1280 1440 $BPP
	;;
"1080p60hz")
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 $BPP
	;;
"1080i60hz")
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 $BPP
	;;
"1080i50hz")
	echo 1080i60 > /sys/class/display/mode
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 $BPP
	;;
"1080p50hz")
	echo 1080p60 > /sys/class/display/mode
	fbset -fb /dev/fb0 -g 1920 1080 1920 2160 $BPP
	;;
"480cvbs")
	fbset -fb /dev/fb0 -g 1280 960 1280 1920 $BPP
	fbset -fb /dev/fb1 -g $BPP $BPP $BPP $BPP $BPP
	echo 0 0 1279 959 > /sys/class/graphics/fb0/free_scale_axis
	echo 30 10 669 469 > /sys/class/graphics/fb0/window_axis
	echo 640 > /sys/class/graphics/fb0/scale_width
	echo 480 > /sys/class/graphics/fb0/scale_height
	echo 0x10001 > /sys/class/graphics/fb0/free_scale
	;;
"576cvbs")
	fbset -fb /dev/fb0 -g 1280 960 1280 1920 $BPP
	fbset -fb /dev/fb1 -g $BPP $BPP $BPP $BPP $BPP
	echo 0 0 1279 959 > /sys/class/graphics/fb0/free_scale_axis
	echo 35 20 680 565 > /sys/class/graphics/fb0/window_axis
	echo 720 > /sys/class/graphics/fb0/scale_width
	echo 576 > /sys/class/graphics/fb0/scale_height
	echo 0x10001 > /sys/class/graphics/fb0/free_scale
	;;
esac

fi 
# End of reading the video output mode and setting it for emuelec to avoid video flicking.
# The codes can be simplified with "elseif" sentences.
# The codes for 480I and 576I are adjusted to avoid overscan.
# Forece 720p50hz to 720p60hz and 1080i/p60hz to 1080i/p60hz since 50hz would make video very choppy.
