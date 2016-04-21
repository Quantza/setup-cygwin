#!/bin/bash
# Simple setup.sh for configuring Ubuntu 14.04 and derivatives,
# for headless setup.

OLDDIR="$PWD"

cd "$HOME"

# Install git
$PKG_INSTALL_PREFIX git
$PKG_INSTALL_PREFIX git-completion 
$PKG_INSTALL_PREFIX git-gui 
$PKG_INSTALL_PREFIX git-svn
$PKG_INSTALL_PREFIX gitk

$PKG_INSTALL_PREFIX curl
$PKG_INSTALL_PREFIX wget

# Install tex-live prequisites
$PKG_INSTALL_PREFIX perl
$PKG_INSTALL_PREFIX fontconfig
$PKG_INSTALL_PREFIX ghostscript
$PKG_INSTALL_PREFIX libXaw7
$PKG_INSTALL_PREFIX ncurses

# Remove old files
CURRENT_TEX_LIVE_VERSION="2015"
TEX_INSTALL_DIR="/usr/local/texlive/""$CURRENT_TEX_LIVE_VERSION"
TEX_USER_DIR="$HOME"/".texlive""$CURRENT_TEX_LIVE_VERSION"

if [ ! -d $TEX_INSTALL_DIR ]; then
    rm -rf $TEX_INSTALL_DIR
fi

if [ ! -d $TEX_USER_DIR ]; then
    rm -rf $TEX_USER_DIR
fi

# Setup Texlive install
TEX_DIR=$MY_DEV_DIR/texlive
TEX_INSTALL_FILES=$TEX_DIR/install

if [ ! -d $TEX_DIR ]; then
    mkdir $TEX_DIR
fi

if [ ! -d $TEX_INSTALL_FILES ]; then
    mkdir $TEX_INSTALL_FILES
fi

# Get and install tex-live
cd $TEX_INSTALL_FILES

if [ -f install-tl-unx.tar.gz ]; then
    rm install-tl-unx.tar.gz
fi

wget -q -0 http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar -xzvf install-tl-unx.tar.gz
cd install-tl-unx
install-tl -gui text

cd $HOME
#PATH=/usr/local/texlive/2015/bin/i386-linux:$PATH

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
$PKG_INSTALL_PREFIX rlwrap

# Install emacs
$PKG_INSTALL_PREFIX emacs

#Install tmux
$PKG_INSTALL_PREFIX tmux

# Install Heroku toolbelt
# https://toolbelt.heroku.com/debian
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

#Install restler, cheerio and commander for node.js

#Rest client
npm install restler

#cmdline in js
npm install commander

#To use jQuery on a server - windows-friendly
npm install cheerio

#Web app framework
npm install -g express

cd "$OLDDIR"

