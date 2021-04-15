# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)

PKG_NAME="emuelec-emulationstation"
PKG_VERSION="87d5ece0dc6efa9dd3352d836e78627d9d39f3ad"
PKG_GIT_CLONE_BRANCH="EmuELEC"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/EmuELEC/emuelec-emulationstation"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2-git freetype curl freeimage vlc bash rapidjson ${OPENGLES} SDL2_mixer fping p7zip"
PKG_SECTION="emuelec"
PKG_NEED_UNPACK="busybox"
PKG_SHORTDESC="Emulationstation emulator frontend"
PKG_BUILD_FLAGS="-gold"
GET_HANDLER_SUPPORT="git"

# themes for Emulationstation
PKG_DEPENDS_TARGET="$PKG_DEPENDS_TARGET Crystal"

PKG_CMAKE_OPTS_TARGET=" -DENABLE_EMUELEC=1 -DDISABLE_KODI=1 -DENABLE_FILEMANAGER=1"

if [[ ${DEVICE} == "GameForce" ]]; then
PKG_CMAKE_OPTS_TARGET+=" -DENABLE_GAMEFORCE=1"
fi

if [[ ${DEVICE} == "OdroidGoAdvance"  ]]; then
PKG_CMAKE_OPTS_TARGET+=" -DODROIDGOA=1"
fi

makeinstall_target() {
	mkdir -p $INSTALL/usr/config/emuelec/configs/locale/i18n/charmaps
	cp -rf $PKG_BUILD/locale/lang/* $INSTALL/usr/config/emuelec/configs/locale/
	cp -PR "$(get_build_dir glibc)/localedata/charmaps/UTF-8" $INSTALL/usr/config/emuelec/configs/locale/i18n/charmaps/UTF-8
	
	mkdir -p $INSTALL/usr/lib
	ln -sf /storage/.config/emuelec/configs/locale $INSTALL/usr/lib/locale
	
	mkdir -p $INSTALL/usr/config/emulationstation/resources
    cp -rf $PKG_BUILD/resources/* $INSTALL/usr/config/emulationstation/resources/
    
	mkdir -p $INSTALL/usr/lib/python2.7
	cp -rf $PKG_DIR/bluez/* $INSTALL/usr/lib/python2.7
	
    mkdir -p $INSTALL/usr/bin
    ln -sf /storage/.config/emulationstation/resources $INSTALL/usr/bin/resources
    cp -rf $PKG_BUILD/emulationstation $INSTALL/usr/bin
    cp -PR "$(get_build_dir glibc)/.$TARGET_NAME/locale/localedef" $INSTALL/usr/bin

	mkdir -p $INSTALL/etc/emulationstation/
	ln -sf /storage/.config/emulationstation/themes $INSTALL/etc/emulationstation/
   
	mkdir -p $INSTALL/usr/config/emulationstation
	cp -rf $PKG_DIR/config/scripts $INSTALL/usr/config/emulationstation
	cp -rf $PKG_DIR/config/*.cfg $INSTALL/usr/config/emulationstation

	chmod +x $INSTALL/usr/config/emulationstation/scripts/*
	chmod +x $INSTALL/usr/config/emulationstation/scripts/configscripts/*
	find $INSTALL/usr/config/emulationstation/scripts/ -type f -exec chmod o+x {} \; 
	
	# Vertical Games are only supported in the OdroidGoAdvance
    if [[ ${DEVICE} != "OdroidGoAdvance" ]]; then
        sed -i "s|, vertical||g" "$INSTALL/usr/config/emulationstation/es_features.cfg"
    fi
	
	# Amlogic project has an issue with mixed audio
    if [[ ${PROJECT} == "Amlogic" ]]; then
        sed -i "s|</config>|	<bool name=\"StopMusicOnScreenSaver\" value=\"false\" />\n</config>|g" "$INSTALL/usr/config/emulationstation/es_settings.cfg"
    fi

    if [[ "${DEVICE}" == "OdroidGoAdvance" ]] || [[ "${DEVICE}" == "GameForce" ]]; then
        sed -i "s|<\/config>|	<string name=\"GamelistViewStyle\" value=\"Small Screen\" />\n<string name=\"ThemeSystemView\" value=\"classic\" />\n<\/config>|g" "$INSTALL/usr/config/emulationstation/es_settings.cfg"
    fi
    
    
}

post_install() {  
	enable_service emustation.service
	mkdir -p $INSTALL/usr/share
	ln -sf /storage/.config/emuelec/configs/locale $INSTALL/usr/share/locale
	if [ "$DEVICE" == "OdroidgoAdvance" ] || [ "$DEVICE" == "GameForce" ]; then
		mv $INSTALL/usr/config/emulationstation/scripts/drastic/config/drastic.cfg_oga $INSTALL/usr/config/emulationstation/scripts/drastic/config/drastic.cfg
	else
		rm -rf $INSTALL/usr/config/emulationstation/scripts/drastic
	fi
}
