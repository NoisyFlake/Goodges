ARCHS = arm64 arm64e 

FINALPACKAGE = 1

include ~/theos/makefiles/common.mk

TWEAK_NAME = Goodges

Goodges_FILES  = include/GGPrefsManager.m include/UIColor+Goodges.m
Goodges_FILES += Goodges.xm

Goodges_FRAMEWORKS = UIKit CoreGraphics Foundation QuartzCore

Goodges_CFLAGS += -Iinclude/

Goodges_LIBRARIES = colorpicker applist

include $(THEOS_MAKE_PATH)/tweak.mk

before-all::
	@cp -pf ./control ./layout/DEBIAN/control

after-install::
	install.exec "killall -9 backboardd"

SUBPROJECTS += prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
