#!/usr/bin/env sh

# apt update
install_packages git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev 
install_packages screen cpulimit htop ca-certificates

BASEDIR=$(pwd)

mkdir -p stage
mkdir -p logs
cd stage

git clone https://github.com/xmrig/xmrig.git
cd xmrig
mkdir build
cd build
cmake ..
make

cd $BASEDIR
ln -s stage/xmrig/build/xmrig .
