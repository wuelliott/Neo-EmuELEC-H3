# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Frank Hartung (supervisedthinking (@) gmail.com)

PKG_NAME="adlmidi"
PKG_VERSION="0b87eee9df14fe24f1827a695a712ccb6c11e980"
PKG_LICENSE="boost Software License - Version 1.0 - August 17th, 2003"
PKG_SITE="https://github.com/bisqwit/adlmidi"
PKG_URL="https://github.com/bisqwit/adlmidi.git"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="OPL3/OPN2 synthesizer using ADLMIDI and OPNMIDI, for Jack and cross-platform audio"
PKG_BUILD_FLAGS="+pic"
GET_HANDLER_SUPPORT="git"
PKG_TOOLCHAIN="make"

pre_configure_target() {
sed -i -e "s/sdl2-config/\$\{LIB_PREFIX\}\/bin\/sdl2-config/" $PKG_BUILD/Makefile
LDFLAGS="$LDFLAGS -Wl,-rpath='$LIB_PREFIX\/lib\/\'"
export LIB_PREFIX=${LIB_PREFIX}
}


make_target() {
    export CC=${CC}
	export CXX=${CXX}
	make -j4 
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/bin/
	cp $PKG_BUILD/adlmidi $INSTALL/usr/bin/
}
