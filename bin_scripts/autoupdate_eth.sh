#!/bin/bash

if [ ! $(isVarDefined $MY_BIN_DIR) ]; then
	MY_BIN_DIR="$HOME/bin";
fi

if [ ! $(isVarDefined $MY_GIT_REPO_DIR) ]; then
	MY_GIT_REPO_DIR="$HOME/GitRepos";
fi

echo Updating and building go-ethereum, cpp-ethereum and mist-wallet...

echo ---go-ethereum---
cd $MY_GIT_REPO_DIR/go-ethereum
make clean
git pull
#git checkout release/1.3.6
make geth
echo ---go-ethereum was compiled successfully---

echo ---cpp-ethereum---
cd $MY_GIT_REPO_DIR/cpp-ethereum
git pull
git submodule update --init
git checkout develop
#git checkout release
mkdir build
cd build

# Compile enough for normal usage and with support for the full chain explorer
cmake ..
#cmake .. -DCMAKE_BUILD_TYPE=Debug -DBUNDLE=user -DFATDB=1 -DETHASHCL=1 

# 4 threads # Full processor(s) == make -j$(nproc)
make -j4

GETH_SUFFIX=go-ethereum/build/bin/geth
ETH_SUFFIX=cpp-ethereum/build/eth/eth
ALETH_SUFFIX=cpp-ethereum/build/alethzero/alethzero
ETHMINER_SUFFIX=cpp-ethereum/build/libethereum/ethminer

ln -sb "$MY_GIT_REPO_DIR"/"$GETH_SUFFIX" "$MY_BIN_DIR"/geth_dev
ln -sb "$MY_GIT_REPO_DIR"/"$ETH_SUFFIX" "$MY_BIN_DIR"/eth_dev
ln -sb "$MY_GIT_REPO_DIR"/"$ALETH_SUFFIX" "$MY_BIN_DIR"/alethzero_dev
ln -sb "$MY_GIT_REPO_DIR"/"$ETHMINER_SUFFIX" "$MY_BIN_DIR"/ethminer_dev

chmod +x "$MY_GIT_REPO_DIR"/"$GETH_SUFFIX"
chmod +x "$MY_GIT_REPO_DIR"/"$ETH_SUFFIX"
#chmod +x "$MY_GIT_REPO_DIR"/"$ALETH_SUFFIX"
chmod +x "$MY_GIT_REPO_DIR"/"$ETHMINER_SUFFIX"

echo ---cpp-ethereum was compiled successfully---

echo ---mist-wallet---
cd $MY_GIT_REPO_DIR
git clone https://github.com/ethereum/mist.git
cd mist
git submodule update --init
npm install

echo ---mist-wallet was compiled successfully---
