# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Matthew Wang(https://github.com/asakous)

PKG_NAME="quakesdlgles1"
PKG_VERSION="284d86fa8e270c8ac9a32e86d909baf2a4da3293"
#PKG_SHA256="d008d6d0c7dca4454646265678236a80b24933739df9bca4abfaf064878d9934"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/angjminer/QuakeSdlGles1"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git SDL2_image"
PKG_SHORTDESC="This is id software's Quake(1) converted to sdl2/gles 1.1. look in the origsrc folder for terms of use."
PKG_LONGDESC="This is id software's Quake(1) converted to sdl2/gles 1.1. look in the origsrc folder for terms of use."
PKG_TOOLCHAIN="cmake"
GET_HANDLER_SUPPORT="git"

#pre_configure_target() {
#sed -i "s/start_fullscreen = false/start_fullscreen = true/" "$PKG_BUILD/SDLPoP.ini"
#sed -i "s/enable_info_screen = true;/enable_info_screen = false;/" "$PKG_BUILD/SDLPoP.ini"
#}

#make_target() {
#	cd $PKG_BUILD/src/
#	mkdir -p build
#	cd build/
#	cmake ..
#	make CC=cc
#}

pre_configure_target() {
#PKG_CMAKE_OPTS_TARGET=" -DSDL2_LIBRARIES=$SYSROOT_PREFIX/usr/lib"
LDFLAGS="$LDFLAGS -lGLESv2"
}

makeinstall_target() {
	mkdir -p $INSTALL/usr/bin/quake1/
	cp $PKG_BUILD/.${TARGET_NAME}/QSdlGles $INSTALL/usr/bin/quake1/
}
