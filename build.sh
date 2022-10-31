#!/bin/sh

VERSION="v22.03.2"

# Download packages
git clone https://github.com/openwrt/packages.git


# Download and update the sources
git clone https://github.com/openwrt/openwrt.git
cd openwrt
git pull
 
# Select a specific code revision
# git branch -a
# git tag
git checkout $VERSION

mkdir -pv package/helloworld
cp -rv ../packages/net/{dns2socks,microsocks,ipt2socks,pdnsd-alt,redsocks2} package/helloworld/

# Update the feeds
./scripts/feeds update -a
./scripts/feeds install -a
 
# Configure the firmware image and the kernel
# make menuconfig
# make -j $(nproc) kernel_menuconfig
# cp ../config .
wget https://mirrors.ustc.edu.cn/openwrt/releases/22.03.2/targets/bcm27xx/bcm2711/config.buildinfo -O .config
 
# Build the firmware image
make -j $(nproc) defconfig download clean world
