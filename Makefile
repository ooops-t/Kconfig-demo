TARGET=demo
-include ./include/config/auto.conf
LDFLAGS= -I./include/generated

obj-y := main.c
obj-$(CONFIG_DINNER) += demo.c

all: $(TARGET)
$(TARGET): $(obj-y) FORCE
	gcc $(LDFLAGS) -o $@ $(obj-y)


%_defconfig:
	./scripts/conf --defconfig=configs/$@ Kconfig
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
	
savedefconfig:
	./scripts/conf -s --savedefconfig defconfig Kconfig

clean:
	-rm -rf $(TARGET)
	-rm -rf ./include/config/* ./include/generated/*
	-rm -rf .config .config.old

PHONY +=FORCE
FORCE:

.PHONY: $(PHONY)
