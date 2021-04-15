# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2021-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="sonic2013"
PKG_VERSION="a4baf7d08095e416d2638b2ee13d33173f54d2a1"
PKG_ARCH="any"
PKG_SITE="https://github.com/Rubberduckycooly/Sonic-1-2-2013-Decompilation"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git"
PKG_SHORTDESC="Sonic 1/2 (2013) Decompilation"
PKG_TOOLCHAIN="make"

makeinstall_target() {
mkdir -p $INSTALL/usr/bin
cp bin/sonic2013 $INSTALL/usr/bin

mkdir -p $INSTALL/usr/config/emuelec/configs/sonic
cp $PKG_DIR/config/* $INSTALL/usr/config/emuelec/configs/sonic
} 
