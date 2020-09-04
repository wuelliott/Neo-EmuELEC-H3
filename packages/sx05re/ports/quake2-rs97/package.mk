# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Matthew Wang(https://github.com/asakous)

PKG_NAME="quake2-rs97"
PKG_VERSION="82dc23057d887d3fa9bdf6b6dab6de6f47808d61"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/gameblabla/quake2-rs97"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL"
PKG_SHORTDESC="sm64ex."
PKG_LONGDESC="quake2."
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

				
pre_configure_target() {
cp -rf $PKG_DIR/makefile/* $PKG_BUILD
export SYSROOT_PREFIX=${SYSROOT_PREFIX}
}

make_target() {
    export CC=${CC}
	export CXX=${CXX}
	export SYSROOT_PREFIX=${SYSROOT_PREFIX}
	export TOOLCHAIN=${TOOLCHAIN}
	make -j4 -f Makefile.H3
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/bin/quake2/
	cp $PKG_BUILD/quake2 $INSTALL/usr/bin/quake2/
}
