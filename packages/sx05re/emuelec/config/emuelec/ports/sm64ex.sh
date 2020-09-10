#!/bin/bash

# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Shanti Gilbert (https://github.com/shantigilbert)

# Source predefined functions and variables
. /etc/profile

PORT="sm64ex"

# init_port binary audio(alsa. pulseaudio, default)
init_port ${PORT} alsa

${PORT}

end_port
