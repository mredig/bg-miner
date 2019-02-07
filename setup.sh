#!/usr/bin/env sh

sudo apt update
sudo apt install git build-essential cmake libuv1-dev libmicrohttpd-dev libssl-dev 
sudo apt install screen cpulimit htop

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
