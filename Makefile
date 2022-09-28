TARGET=demo
-include ./include/config/auto.conf
LDFLAGS= -I./include/generated

obj-y := main.c
obj-$(CONFIG_DINNER) += demo.c

all: $(TARGET)
$(TARGET): $(obj-y) FORCE
	gcc $(LDFLAGS) -o $@ $(obj-y)

defconfig:
	./scripts/conf Kconfig
	./scripts/conf -s --oldconfig Kconfig

allyesconfig:
	./scripts/conf -s --allyesconfig Kconfig
	./scripts/conf -s --oldconfig Kconfig

allnoconfig:
	./scripts/conf -s --allnoconfig Kconfig
	./scripts/conf -s --oldconfig Kconfig

alldefconfig:
	./scripts/conf -s --alldefconfig Kconfig
	./scripts/conf -s --oldconfig Kconfig

menuconfig:
	./scripts/mconf Kconfig
	./scripts/conf -s --oldconfig Kconfig

clean:
	-rm $(TARGET)
	-rm -rf ./include/config/* ./include/generated/*
	-rm -rf .config .config.old

PHONY +=FORCE
FORCE:

.PHONY: $(PHONY)
