# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Matthew Wang(https://github.com/asakous)

PKG_NAME="sm64ex"
PKG_VERSION="f5005418348cf1a53bfa75ff415a513ef0b9b273"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/sm64pc/sm64ex"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git SDL2_image"
PKG_SHORTDESC="sm64ex."
PKG_LONGDESC="sm64ex."
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

				
pre_configure_target() {
cp -rf $PKG_DIR/rom/* $PKG_BUILD
export SYSROOT_PREFIX=${SYSROOT_PREFIX}
}

make_target() {
    export CC=${CC}
	export CXX=${CXX}
	export SYSROOT_PREFIX=${SYSROOT_PREFIX}
	make VERSION=us TARGET_RPI=1 -j4 CROSS=$TARGET_KERNEL_PREFIX
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/bin/sm64ex/
	cp $PKG_BUILD/build/us_pc/*.arm $INSTALL/usr/bin/sm64ex/
}
