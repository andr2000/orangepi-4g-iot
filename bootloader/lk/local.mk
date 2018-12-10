PROJECT ?= bd6737m_35g_b_m0
ARM_CPU ?= cortex-a15
BUILD_NANDWRITE ?= 1
# for Yocto SDK/build
TOOLCHAIN_PREFIX ?= $(TARGET_PREFIX)

# Enable debug level here instead of project file:
# Some projects check for the DEBUG value and some are just
# happy if it is set, even if to 0
#DEBUG := 2

# XXX: Detect which floating point ABI the toolchain has:
# if this is a hardfp, then we need to provide a softfp libgcc
TOOLCHAIN_LIBGCC = $(shell $(CC) -print-libgcc-file-name)
LIBGCC_HARDFP ?= $(shell $(TARGET_PREFIX)readelf -A $(TOOLCHAIN_LIBGCC) | grep "VFP registers" | uniq)
ifneq ($(LIBGCC_HARDFP),)
LIBGCC = $(CURDIR)/prebuilt/libgcc-softfp.a
#CFLAGS += $(LIBGCC)
$(info ================================================================= )
$(info WARN! Toolchain is built with hardfp, providing prebuilt at )
$(info $(LIBGCC) )
$(info ================================================================= )
endif
