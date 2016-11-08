# USB NIC Driver for ESXi 5.1/5.5/6.0 (ASIX)  

AISX ax88179_178a driver for ESXi

Key features:

* Supports ASIX AX88179 and AX88178a
* TCP, UDP and IPv4 checksum offload (RX and TX)
* TCP, UDP and IPv6 checksum offload (RX and TX)
* Scatter-Gather support
* TCP Segmentation Offload support
* Wake on LAN support
* VLAN support
* Jumbo Frames (4k)

###Table of Contents  

* [Tested Devices](#tested-devices)
* [Required Software](#required-software)
* [Setup](#setup)
	* [Prepare the build environment](#prepare-the-build-environment) 
	*  [Building the driver](#building-the-driver)

### Tested Devices

The following devices were tested with this driver.

* [StarTech USB 3.0 to RJ45 Ethernet LAN 10/100/100 Network Adapter](https://www.amazon.co.uk/gp/product/B0095EFXMC/ref=oh_aui_detailpage_o04_s00?ie=UTF8&psc=1)

* [StarTech USB 3.0 to Dual Port Gigabit Ethernet Adapter NIC with USB Port](https://www.amazon.co.uk/gp/product/B00D8XTOD0/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1)

* [Plugable USB 3.0 to 10/100/1000 Gigabit Ethernet LAN Network Adapter](https://www.amazon.co.uk/gp/product/B00AQM8586/ref=oh_aui_detailpage_o02_s00?ie=UTF8&psc=1)

### Required Software

CentOS 5.3-x86 64 bit DVD ISO - <http://mirror.ash.fastserv.com/centos/5.3/isos/x86_64/CentOS-5.3-x86_64-bin-DVD.iso>

VMware ESXi 6.0 source code (VMware-ESXI-60U2-ODP.iso) and build toolchain (VMware-TOOLCHAIN-ODP-vsphere60u2-Mar-01-2016.iso) 

* ESXi 6.0 Update 2 OSS Download - <https://my.vmware.com/web/vmware/details?downloadGroup=ESXI60U2_OSS&productId=491>

VMware ESXi 5.5 source code (VMware-ESX-5.5.0u03-ODP.iso) and build toolchain (VMware-550u3-TOOLCHAIN-ODP_21_July_2015.iso)

* ESXi 5.5 Update 3 OSS Download - <https://my.vmware.com/web/vmware/details?downloadGroup=ESXI55U3_OSS&productId=353>

VMware ESXi 5.1 source code and build toolchain are both included in a single file (VMware-esx-open-source-5.0.0u2.oss.tgz).

* ESXi 5.1 Update 2 OSS Download - <https://my.vmware.com/web/vmware/details?productId=229&downloadGroup=VSPHERE50U2_OSS>

### Setup

The embedded documentation for the ESXi open source disclosure packages recommends the build should be performed on a CentOS 5.3 x64 system to produce 64-bit packages. There are other systems mentioned (CentOS 32-bit, Red Hat, FreeBSD and Windows), so take your pick! 

To make life easier, I customised the Kickstart file provided with the ESXi 5.5 Toolchain ISO (under the **config** folder) to build a CentOS 5.3 x64 server VM. Once it is up and running, we deviate a bit from the instructions provided by VMware.

The initial build directory structure should be:

~~~sh
mkdir -p /build/{vsphere,toolchain}
~~~

The next steps are a bit different, depending on whether the build environment is being prepared for ESXi 5.1 or later versions:

#### Prepare the build environment

<u>*ESXi 5.1*</u>

Extract the contents of the compressed tar archive to /build/vsphere:

~~~sh
cd /build/vsphere
tar xvf /path/to/VMware-esx-open-source-5.1.0u2.oss.tar --strip-components=1 server/vmkdrivers-gpl
cd vmkdrivers-gpl
~~~
You are now ready to compile the build toolchain:

_glibc_

~~~sh
cd glibc-2.3.2-95.44
bash ./BUILD.txt
cd ..
~~~

_binutils_

~~~sh
cd binutils-2.17.50.0.15-modcall
bash ./BUILD.txt
cd ..
~~~

_gcc_

~~~sh	
cd gcc-4.1.2-9
bash ./BUILD.txt
cd ..		
~~~



<u>*ESXi 5.5 & 6.0*</u>

Unlike ESXi 5.1, the ODP source code and the build toolchain for 5.5 and 6.0 are distributed as two separate ISO images. The two ISOs include hundreds of packages, but only a small subset is actually required to build the drivers.

First, copy the **vmkdrivers-gpl** folder from the ODP ISO (either VMware-ESX-5.5.0u03-ODP.iso or VMware-ESXI-60U2-ODP.iso) to /build/vsphere/

```sh
cp -r /cdrom/vmkdrivers-gpl /build/vsphere
umount /cdrom
```

**Note:** The above assumes that */cdrom* is the mount point for the ISO/Physical DVD — your environment might differ.

The toolchain ISO (VMware-550u3-TOOLCHAIN-ODP_21_July_2015.iso or VMware-TOOLCHAIN-ODP-vsphere60u2-Mar-01-2016.iso) includes the source for multiple libraries and tools, but only glibc, binutils and gcc at specific versions are required.

```sh
cd /build/toolchain
tar xvf /cdrom/tc-src.tar src/gcc-4.4.3-2 src/glibc-2.3.2-95.44 src/binutils-2.20.1-1 src/common/functions 
umount /cdrom
```

**Note:** The above assumes that */cdrom* is the mount point for the ISO/Physical DVD — your environment might differ.

Compile the build toolchain:

*glibc*

```sh
cd /build/toolchain/src/glibc-2.3.2-95.44
bash ./install.sh
```

*binutils*

```sh
cd /build/toolchain/src/binutils-2.20.1-1
bash ./install.sh
```

*gcc*

```sh
cd /build/toolchain/src/gcc-4.4.3-2
bash ./install.sh
```



#### Building the driver

There is a little bit more preparation to be done to build the driver. Again, some of the steps are different depending on the version of ESXi.

<u>*Common*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
tar zxvf vmkdriver-gpl.tgz
```


Create the directory for the driver's source code. The same source files are used to build the driver on all environments.

<u>*ESXi 5.1*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
mkdir vmkdrivers/src_9/drivers/usb/net/ax88179
cp /path/to/source/ax88179_178a.* vmkdrivers/src_9/drivers/usb/net/ax88179/
```

<u>*ESXi 5.5 & 6.0*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
mkdir vmkdrivers/src_92/drivers/usb/net/ax88179
cp /path/to/source/ax88179_178a.* vmkdrivers/src_92/drivers/usb/net/ax88179/
```



Create the directory that will hold the driver's namespace dependencies map:

<u>*ESXi 5.1*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
mkdir BLD/build/HEADERS/CUR-92-vmkdrivers-namespace/vmkernel64/release/ax88179
echo -e "VMK_NAMESPACE_REQUIRED(\"com.vmware.usb\", \"9.2.1.0\");\
\nVMK_NAMESPACE_REQUIRED(\"com.vmware.usbnet\", \"9.2.1.0\");"\
> BLD/build/HEADERS/CUR-92-vmkdrivers-namespace/vmkernel64/release/ax88179/__namespace.h
```

<u>*ESXi 5.5*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
mkdir BLD/build/HEADERS/CUR-92-vmkdrivers-namespace/vmkernel64/release/ax88179
echo -e "VMK_NAMESPACE_REQUIRED(\"com.vmware.usb\", \"9.2.2.0\");\
\nVMK_NAMESPACE_REQUIRED(\"com.vmware.usbnet\", \"9.2.2.0\");"\
> BLD/build/HEADERS/CUR-92-vmkdrivers-namespace/vmkernel64/release/ax88179/__namespace.h
```

<u>*ESXi 6.0*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
mkdir BLD/build/HEADERS/92-vmkdrivers-namespace/vmkernel64/release/ax88179
echo -e "VMK_NAMESPACE_REQUIRED(\"com.vmware.usb\", \"9.2.3.0\");\
\nVMK_NAMESPACE_REQUIRED(\"com.vmware.usbnet\", \"9.2.3.0\");"\
> BLD/build/HEADERS/92-vmkdrivers-namespace/vmkernel64/release/ax88179/__namespace.h
```

Finally, copy the appropriate build script to **/build/vsphere/vmkdrivers-gpl** and compile the driver.

<u>*ESXi 5.1*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
cp /path/to/scripts/build-ax88179_u51.sh .
chmod a+x build-ax88179_u51.sh
./build-ax88179_u51.sh
```

<u>*ESXi 5.5*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
cp /path/to/scripts/build-ax88179_u55.sh .
chmod a+x build-ax88179_u55.sh
./build-ax88179_u55.sh
```

<u>*ESXi 6.0*</u>

```sh
cd /build/vsphere/vmkdrivers-gpl
cp /path/to/scripts/build-ax88179_u60.sh .
chmod a+x build-ax88179_u60.sh
./build-ax88179_u60.sh
```
  

