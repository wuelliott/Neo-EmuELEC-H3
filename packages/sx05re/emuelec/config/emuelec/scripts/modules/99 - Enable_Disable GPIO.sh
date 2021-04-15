#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

# Helper script to activate/desactivate WLAN from command line

# Usage :
# wifi connect <ssid> <passphrase>
# wifi disconnect <ssid> 
# wifi scan
# wifi status

#####################################################

# downloaded from : https://jira.automotivelinux.org/secure/attachment/10300/wifi

### global vars ###

source /emuelec/scripts/env.sh
source "$scriptdir/scriptmodules/supplementary/esthemes.sh"
rp_registerAllModules

joy2keyStart

function gpio_enable() {
	systemctl start gpio
}

function gpio_disable() {
	systemctl stop gpio
}

function gpio_status() {
	systemctl status gpio
}

GPIO_STATUS=`ps -eaf | grep -i tz_gpio_controller |sed '/^$/d' | wc -l`

if [[ $GPIO_STATUS > 1 ]]
then
	if dialog --ascii-lines --yesno "GPIO service is running! are you sure you want to disable it?"  22 76 >/dev/tty; then
	gpio_disable
	echo "0" > /storage/.config/gpio/service.flag
	fi
else
  	if dialog --ascii-lines --yesno "GPIO service is NOT running! are you sure you want to enable it?"  22 76 >/dev/tty; then
	gpio_enable
	echo "1" > /storage/.config/gpio/service.flag
	fi
fi  
