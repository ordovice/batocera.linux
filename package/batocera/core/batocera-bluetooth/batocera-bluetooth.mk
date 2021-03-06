################################################################################
#
# BATOCERA BLUETOOTH
#
################################################################################

BATOCERA_BLUETOOTH_VERSION = 1.1
BATOCERA_BLUETOOTH_LICENSE = GPL
BATOCERA_BLUETOOTH_SOURCE=

BATOCERA_BLUETOOTH_STACK=

ifneq ($(BR2_PACKAGE_BATOCERA_RPI_VCORE)$(BR2_PACKAGE_BATOCERA_RPI_MESA3D),)
	BATOCERA_BLUETOOTH_STACK=bcm921 piscan
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_TINKERBOARD),y)
	BATOCERA_BLUETOOTH_STACK=rfkreset rtk115
else ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCKPRO64),y)
	BATOCERA_BLUETOOTH_STACK=rfkreset bcm150
endif

define BATOCERA_BLUETOOTH_INSTALL_TARGET_CMDS
	cp $(BR2_EXTERNAL_BATOCERA_PATH)/package/batocera/core/batocera-bluetooth/S32bluetooth.template $(TARGET_DIR)/etc/init.d/S32bluetooth
	sed -i -e s+"@INTERNAL_BLUETOOTH_STACK@"+"$(BATOCERA_BLUETOOTH_STACK)"+ $(TARGET_DIR)/etc/init.d/S32bluetooth
endef

$(eval $(generic-package))
