#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

# based on https://github.com/RetroPie/RetroPie-Setup/blob/master/scriptmodules/supplementary/emulationstation/configscripts/retroarch.sh

TMPCONF=$(mktemp)

function onstart_gamecontrollerdb_joystick() {
    echo -ne "$DEVICE_GUID,$DEVICE_NAME,platform:Linux," > "${TMPCONF}"
}

function map_gamecontrollerdb_joystick() {
    local input_name="$1"
    local input_type="$2"
    local input_id="$3"
    local input_value="$4"

    local keys

    case "$input_name" in
        up)
            keys=("dpup")
            ;;
        down)
            keys=("dpdown")
            ;;
        left)
            keys=("dpleft")
            ;;
        right)
            keys=("dpright")
            ;;
        a)
            keys=("a")
            ;;
        b)
            keys=("b")
            ;;
        x)
            keys=("x")
            ;;
        y)
            keys=("y")
            ;;
        leftshoulder)
            keys=("leftshoulder")
            ;;
        rightshoulder)
            keys=("rightshoulder")
            ;;
        lefttrigger)
            keys=("lefttrigger")
            ;;
        righttrigger)
            keys=("righttrigger")
            ;;
        leftthumb)
            keys=("leftstick")
            ;;
        rightthumb)
            keys=("rightstick")
            ;;
        start)
            keys=("start")
            ;;
        select)
            keys=("back")
            ;;
        leftanalogleft)
            keys=("leftx")
            ;;
        leftanalogup)
            keys=("lefty")
            ;;
        rightanalogleft)
            keys=("rightx")
            ;;
        rightanalogup)
            keys=("righty")
            ;;
        hotkeyenable)
            keys=("guide")
            ;;
    esac
    
    local key
    local value
    local type
    for key in "${keys[@]}"; do
        case "$input_type" in
            hat)
                type="h"
                value="$input_id.$input_value"
                ;;
            axis)
                type="a"
                value="$input_id"
                ;;
            button)
                type="b"
                value="$input_id"
                ;;
        esac
        key+=":$type$value"
    done
[[ -z "$key" ]] && continue
echo -en "$key," >> "${TMPCONF}"
}

function onend_gamecontrollerdb_joystick() {
# SDL_GAMECONTROLLERCONFIG_FILE is populated from the export (already in env)
EXISTS=$(grep "$DEVICE_GUID" "$SDL_GAMECONTROLLERCONFIG_FILE" | grep Linux)

if [ -z "$EXISTS" ]; then
  #  echo "$DEVICE_GUID does not exists, adding"
    CONF=$(cat "${TMPCONF}")
    sed -i "/EmuELEC extra gamepads/c # EmuELEC extra gamepads\n$CONF" "$SDL_GAMECONTROLLERCONFIG_FILE"
fi

# cleanup
rm "${TMPCONF}" > /dev/null 2>&1
}
