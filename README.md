# USB NIC Driver for ESXi 5.1/5.5/6.0 (ASIX)

[TOC]

### Tested Devices

The following devices were tested with this driver:

* [StarTech USB 3.0 to RJ45 Ethernet LAN 10/100/100 Network Adapter](https://www.amazon.co.uk/gp/product/B0095EFXMC/ref=oh_aui_detailpage_o04_s00?ie=UTF8&psc=1)

- [StarTech USB 3.0 to Dual Port Gigabit Ethernet Adapter NIC with USB Port](https://www.amazon.co.uk/gp/product/B00D8XTOD0/ref=oh_aui_detailpage_o03_s00?ie=UTF8&psc=1)
- [Plugable USB 3.0 to 10/100/1000 Gigabit Ethernet LAN Network Adapter](https://www.amazon.co.uk/gp/product/B00AQM8586/ref=oh_aui_detailpage_o02_s00?ie=UTF8&psc=1)

### Required Software

CentOS 5.3-x86 64 bit DVD ISO - <http://mirror.ash.fastserv.com/centos/5.3/isos/x86_64/CentOS-5.3-x86_64-bin-DVD.iso>

VMware ESXi 6.0 source code (VMware-ESXI-60U2-ODP.iso) and build toolchain (VMware-TOOLCHAIN-ODP-vsphere60u2-Mar-01-2016.iso) 

* ESXi 6.0 Update 2 OSS Download - <https://my.vmware.com/web/vmware/details?downloadGroup=ESXI60U2_OSS&productId=491>

VMware ESXi 5.5 source code (VMware-ESX-5.5.0u03-ODP.iso) and build toolchain (VMware-550u3-TOOLCHAIN-ODP_21_July_2015.iso)

* ESXi 5.5 Update 3 OSS Download - <https://my.vmware.com/web/vmware/details?downloadGroup=ESXI55U3_OSS&productId=353>

VMware ESXi 5.1 source code and build toolchain are both included in a single file (VMware-esx-open-source-5.0.0u2.oss.tgz).

* ESXi 5.1 Update 2 OSS Download - <https://my.vmware.com/web/vmware/details?productId=229&downloadGroup=VSPHERE50U2_OSS>

### Setup

The embedded documentation for the ESXi open source disclosure packages recommends the build should be performed on a CentOS 5.3 x64 system to produce 64-bit packages. There are other systems mentioned (CentOS 32-bit, Red Hat, FreeBSD and Windows), so take your pick! ;-) 

To make life easier, I customised the Kickstart file provided with the ESXi 5.5 Toolchain ISO (under the config folder) to build a CentOS 5.3 x64 server VM. Once it is up and running, we deviate a bit from the instructions in the README provided by VMware.

The initial build directory structure should be:

```shell
		mkdir -p /build/{vsphere,toolchain}
```

The next steps are bit different, depending on whether the build environment is being prepared for ESXi 5.1 or later versions:

##### _ESXi 5.1_

Extract the contents of the compressed tar archive to /build/vsphere:

~~~sh
		cd /build/vsphere
		tar zxvf /path/to/VMware-esx-open-source-5.0.0u2.oss.tgz
		cd vmkdrivers-gpl
~~~
You are now ready to compile the toolchain:

_glibc_

~~~sh
		cd glibc-2.3.2-95.44
		. BUILD.txt
		cd ..
~~~

_binutils_

~~~sh
		cd binutils-2.17.50.0.15-modcall
		. BUILD.txt
		cd ..
~~~

_gcc_

~~~	sh	
		cd gcc-4.1.2-9
		. BUILD.txt
		cd ..		
~~~
