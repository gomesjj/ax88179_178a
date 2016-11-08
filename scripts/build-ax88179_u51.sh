#!/bin/sh

rm -rf BLD/build/vmkdriver-ax88179-CUR/

# Use gcc version 4.1.2-9
# Below is the internal VMWare location.  Please change as required for your
# installed location.
CC=/build/toolchain/lin32/gcc-4.1.2-9/bin/x86_64-linux-gcc

# Use ld from binutils-2.17.50.0.15-modcall
# Below is the internal VMWare location.  Please change as required for your
# installed location.
LD=/build/toolchain/lin32/binutils-2.17.50.0.15-modcall/bin/x86_64-linux-ld

# PR# 976913 requested that OSS binaries be stripped of debug
LD_OPTS=--strip-debug

# Use GNU grep 2.5.1
GREP=grep
# Use GNU sed 4.5.1
SED=sed
# Use GNU xargs 4.2.27
XARGS=xargs
# Use mkdir from GNU coreutils 5.97
MKDIR=mkdir

# Create output directories
$GREP -v -e "SED" build-ax88179_u51.sh \
| $GREP -o -e "-o [^ ]*\."            \
| $SED -e 's?-o \(.*\)/[^/]*\.?\1?'   \
| $GREP -v -e "\*"                    \
| $XARGS $MKDIR -p

$CC -fwrapv -fno-working-directory -g -ggdb3 -O2 -fno-strict-aliasing -Wall -Werror -Wstrict-prototypes -fPIE -falign-functions=4 -falign-jumps=4 -falign-loops=4 -ffreestanding -fno-common -fno-omit-frame-pointer -fno-strength-reduce -march=x86-64 -mcmodel=small -minline-all-stringops -mno-red-zone -nostartfiles -nostdlib --sysroot=/nowhere -Wdeclaration-after-statement -Wno-unused-value -Wno-pointer-sign -Wno-strict-prototypes -Wno-declaration-after-statement -Wno-declaration-after-statement -DCONFIG_COMPAT -DCPU=x86-64 -DDEBUG_STUB -DEXPORT_SYMTAB -DGPLED_CODE -DKBUILD_MODNAME=\"ax88179\" -DLINUX_MODULE_AUX_HEAP_NAME=vmklnx_ax88179 -DLINUX_MODULE_HEAP_INITIAL=256*1024 -DLINUX_MODULE_HEAP_MAX=8*1024*1024 -DLINUX_MODULE_HEAP_NAME=vmklnx_usb -DLINUX_MODULE_VERSION=\"1.14.4\" -DMODULE -DUSB_DRIVER -DVMKERNEL_MODULE -DVMK_DEVKIT_HAS_API_VMKAPI_BASE -DVMK_DEVKIT_HAS_API_VMKAPI_DEVICE -DVMK_DEVKIT_HAS_API_VMKAPI_ISCSI -DVMK_DEVKIT_HAS_API_VMKAPI_NET -DVMK_DEVKIT_HAS_API_VMKAPI_SCSI -DVMK_DEVKIT_IS_DDK -DVMK_DEVKIT_USES_BINARY_COMPATIBLE_APIS -DVMK_DEVKIT_USES_PUBLIC_APIS -DVMNIX -DVMX86_RELEASE -DVMX86_SERVER -DVMX86_VPROBES -D_LINUX -D_VMKDRVEI -D__KERNEL__ -D__VMKERNEL_MODULE__ -D__VMKERNEL__ -D__VMKLNX__ -D__VMK_GCC_BUG_ALIGNMENT_PADDING__ -D__VMWARE__ -Ivmkdrivers/src_92/drivers/usb/core -IBLD/build/version -IBLD/build/HEADERS/vmkdrivers-vmkernel/vmkernel64/release -Ivmkdrivers/src_92/include -Ivmkdrivers/src_92/include/vmklinux_92 -IBLD/build/HEADERS/CUR-92-vmkdrivers-asm-x64/vmkernel64/release -IBLD/build/HEADERS/vmkapi-current-all-public-bincomp/vmkernel64/release -IBLD/build/HEADERS/CUR-92-vmkdrivers-namespace/vmkernel64/release/ax88179 -include bora/vmkernel/distribute/push-hidden.h -include vmkdrivers/src_92/include/linux/autoconf.h -c -o BLD/build/vmkdriver-ax88179-CUR/release/vmkernel64/SUBDIRS/vmkdrivers/src_92/drivers/usb/net/ax88179/ax88179.o vmkdrivers/src_92/drivers/usb/net/ax88179/ax88179_178a.c

$CC -fwrapv -fno-working-directory -g -ggdb3 -O2 -fno-strict-aliasing -Wall -Werror -Wstrict-prototypes -fPIE -falign-functions=4 -falign-jumps=4 -falign-loops=4 -ffreestanding -fno-common -fno-omit-frame-pointer -fno-strength-reduce -march=x86-64 -mcmodel=small -minline-all-stringops -mno-red-zone -nostartfiles -nostdlib --sysroot=/nowhere -Wdeclaration-after-statement -Wno-unused-value -Wno-pointer-sign -Wno-strict-prototypes -Wno-declaration-after-statement -Wno-declaration-after-statement -DCONFIG_COMPAT -DCPU=x86-64 -DDEBUG_STUB -DEXPORT_SYMTAB -DGPLED_CODE -DKBUILD_MODNAME=\"r8152\" -DLINUX_MODULE_AUX_HEAP_NAME=vmklnx_r8152 -DLINUX_MODULE_HEAP_INITIAL=256*1024 -DLINUX_MODULE_HEAP_MAX=8*1024*1024 -DLINUX_MODULE_HEAP_NAME=vmklnx_usb -DLINUX_MODULE_VERSION=\"2.05.0\" -DMODULE -DUSB_DRIVER -DVMKERNEL_MODULE -DVMK_DEVKIT_HAS_API_VMKAPI_BASE -DVMK_DEVKIT_HAS_API_VMKAPI_DEVICE -DVMK_DEVKIT_HAS_API_VMKAPI_ISCSI -DVMK_DEVKIT_HAS_API_VMKAPI_NET -DVMK_DEVKIT_HAS_API_VMKAPI_SCSI -DVMK_DEVKIT_IS_DDK -DVMK_DEVKIT_USES_BINARY_COMPATIBLE_APIS -DVMK_DEVKIT_USES_PUBLIC_APIS -DVMNIX -DVMX86_RELEASE -DVMX86_SERVER -DVMX86_VPROBES -D_LINUX -D_VMKDRVEI -D__KERNEL__ -D__VMKERNEL_MODULE__ -D__VMKERNEL__ -D__VMKLNX__ -D__VMK_GCC_BUG_ALIGNMENT_PADDING__ -D__VMWARE__ -Ivmkdrivers/src_92/drivers/usb/core -IBLD/build/version -IBLD/build/HEADERS/vmkdrivers-vmkernel/vmkernel64/release -Ivmkdrivers/src_92/include -Ivmkdrivers/src_92/include/vmklinux_92 -IBLD/build/HEADERS/CUR-92-vmkdrivers-asm-x64/vmkernel64/release -IBLD/build/HEADERS/vmkapi-current-all-public-bincomp/vmkernel64/release -IBLD/build/HEADERS/CUR-92-vmkdrivers-namespace/vmkernel64/release/ax88179 -include bora/vmkernel/distribute/push-hidden.h -include vmkdrivers/src_92/include/linux/autoconf.h -c -o BLD/build/vmkdriver-ax88179-CUR/release/vmkernel64/SUBDIRS/vmkdrivers/src_92/common/vmklinux_module.o vmkdrivers/src_92/common/vmklinux_module.c

$LD $LD_OPTS -r -o BLD/build/vmkdriver-ax88179-CUR/release/vmkernel64/ax88179 --whole-archive BLD/build/vmkdriver-ax88179-CUR/release/vmkernel64/SUBDIRS/vmkdrivers/src_92/drivers/usb/net/ax88179/ax88179.o BLD/build/vmkdriver-ax88179-CUR/release/vmkernel64/SUBDIRS/vmkdrivers/src_92/common/vmklinux_module.o
