# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="xash3D"
PKG_VERSION="ddc4d7666874ce050d33ba6cc5781f08180776c5"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/FWGS/xash3d-fwgs"
PKG_URL="https://github.com/FWGS/xash3d-fwgs.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git hlsdk"
PKG_LONGDESC=""
PKG_TOOLCHAIN="manual"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="+lto"
#LIBGL_FB=1 LIBGL_BATCH=1 LD_LIBRARY_PATH=/opt/vc/lib:/home/pi/glshim/lib:. ./xash3d -console -debug
#./xash3d -dev 2 --game value
configure_target() {

  ./waf configure -T release  --disable-gl --disable-vgui --sdl2=${SYSROOT_PREFIX}/usr --enable-gl4es --disable-menu-changegame --enable-lto

}

make_target() {
  ./waf build
}

makeinstall_target() {
 
	mkdir -p $INSTALL/usr/config/emuelec/bin
	mkdir -p $INSTALL/usr/lib/
	cp $PKG_BUILD/build/ref_soft/libref_soft.so $INSTALL/usr/lib/
	cp $PKG_BUILD/build/ref_gl/libref_gl4es.so $INSTALL/usr/lib/
	cp $PKG_BUILD/build/mainui/libmenu.so $INSTALL/usr/lib/
	cp $PKG_BUILD/build/engine/libxash.so $INSTALL/usr/lib/
	cp $PKG_BUILD/build/game_launch/xash3d $INSTALL/usr/config/emuelec/bin

}
