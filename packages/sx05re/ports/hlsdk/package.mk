# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="hlsdk"
PKG_VERSION="93630eae2375bcc25e5596c777a42cc68686ac27"
PKG_LICENSE="GPLv2+"
PKG_SITE="https://github.com/FWGS/hlsdk-xash3d"
PKG_URL="https://github.com/FWGS/hlsdk-xash3d.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git"
PKG_LONGDESC=""
PKG_TOOLCHAIN="manual"
GET_HANDLER_SUPPORT="git"
PKG_BUILD_FLAGS="+lto"

configure_target() {
	cd $PKG_BUILD
  ./waf configure -T release --enable-goldsrc-support --enable-lto 

}

make_target() {
  ./waf build
}

makeinstall_target() {
 
	mkdir -p $INSTALL/usr/lib/
	cp $PKG_BUILD/build/cl_dll/client_armv7hf.so $INSTALL/usr/lib/
	cp $PKG_BUILD/build/dlls/hl_armv7hf.so $INSTALL/usr/lib/


}