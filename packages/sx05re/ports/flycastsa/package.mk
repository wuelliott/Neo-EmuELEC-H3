# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2020-present Matthew Wang(https://github.com/asakous)

PKG_NAME="flycastsa"
PKG_VERSION="170ae3477c5b69975540aa382ac9ce3442d5c40e"
PKG_ARCH="any"
PKG_LICENSE="GPL3"
PKG_SITE="https://github.com/flyinghead/flycast"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git SDL2_image"
PKG_SHORTDESC="flycastsa."
PKG_LONGDESC="flycastsa."
PKG_TOOLCHAIN="make"
GET_HANDLER_SUPPORT="git"

PKG_BUILD_FLAGS="-gold"

pre_configure_target() {
# Flycast defaults to -O3 but then CHD v5 do not seem to work on EmuELEC so we change it to -O2 to fix the issue
PKG_MAKE_OPTS_TARGET="ARCH=${ARCH} HAVE_OPENMP=1 GIT_VERSION=${PKG_VERSION:0:7} FORCE_GLES=1 SET_OPTIM=-O2 HAVE_LTCG=0"
}

pre_make_target() {
   case $PROJECT in
    Amlogic-ng)
      PKG_MAKE_OPTS_TARGET+=" platform=AMLG12B"
      ;;
    Amlogic)
      PKG_MAKE_OPTS_TARGET+=" platform=AMLGX"
    ;; 
    H3)
      PKG_MAKE_OPTS_TARGET+=" platform=odroid"

    ;;   
  esac
  
 if [ "$DEVICE" == "OdroidGoAdvance" ]; then
	PKG_MAKE_OPTS_TARGET+=" platform=classic_armv8_a35"
 fi 
}

make_target() {
  export SYSROOT_PREFIX=${SYSROOT_PREFIX}	
  export CFLAGS="$CFLAGS -DEGL_NO_X11"
  export CXXFLAGS="$CXXFLAGS -DEGL_NO_X11"
  cd $PKG_BUILD/shell/linux
  make CC=$CC CXX=$CXX AS=$CC STRIP=$STRIP  platform=odroid reicast.elf
}


makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp reicast.elf $INSTALL/usr/bin/flycastsa
  cp tools/reicast-joyconfig.py $INSTALL/usr/bin/flycast-joyconfig.py
  mkdir -p $INSTALL/usr/config/emuelec/bin
  cp -r $PKG_DIR/config/* $INSTALL/usr/config/
  cp -r $PKG_DIR/scripts/* $INSTALL/usr/config/emuelec/bin/
}


