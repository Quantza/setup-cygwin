GIT_REPOS_DIR="$HOME/GitRepos"
if [ ! -d $GIT_REPOS_DIR ]; then
    mkdir $GIT_REPOS_DIR
fi

CYG_REPO_NAME="cyg"
CYG_REPO_DIR="$GIT_REPOS_DIR/$CYG_REPO_NAME"
if [ ! -d $CYG_REPO_DIR ]; then
    cd $GIT_REPOS_DIR
    git clone https://github.com/pi0/cyg.git "$($CYG_REPO_NAME)"
    ln -s "$($CYG_REPO_DIR/apt-cyg)" /usr/local/bin/
else
    cd $CYG_REPO_DIR
    git pull
fi

cd $HOME

# Install nvm: node-version manager
# https://github.com/creationix/nvm

apt-cyg install curl
apt-cyg install wget
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | sh

# Load nvm and install latest production node
# https://nodejs.org/
source $HOME/.nvm/nvm.sh
nvm install v0.12
nvm use v0.12

#Set node version for new shells
nvm alias default 0.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install git
apt-cyg install git
apt-cyg install git-completion 
apt-cyg install git-gui 
apt-cyg install git-svn
apt-cyg install gitk

# Install tex-live prequisites
apt-cyg install perl
apt-cyg install fontconfig
apt-cyg install ghostscript
apt-cyg install libXaw7
apt-cyg install ncurses

# Remove old files
CURRENT_TEX_LIVE_VERSION="2015"
TEX_INSTALL_DIR="/usr/local/texlive/""$CURRENT_TEX_LIVE_VERSION"
TEX_USER_DIR="$HOME/.texlive""$CURRENT_TEX_LIVE_VERSION"

if [ ! -d $TEX_INSTALL_DIR ]; then
    rm -rf $TEX_INSTALL_DIR
fi

if [ ! -d $TEX_USER_DIR ]; then
    rm -rf $TEX_USER_DIR
fi

# Setup install
DEV_DIR="$HOME/dev"
TEX_DIR=$DEV_DIR/texlive
TEX_INSTALL_FILES=$TEX_DIR/install

if [ ! -d $DEV_DIR ]; then
    mkdir $DEV_DIR
fi

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
apt-cyg install rlwrap

# Install emacs
apt-cyg install emacs

#Install tmux
apt-cyg install tmux

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

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi

if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi

if [ -d .tmux/ ]; then
    mv .tmux .tmux~
fi

if [ -d .vagrant.d/ ]; then
    mv .vagrant.d .vagrant.d~
fi

if [ -d .tools/ ]; then
    mv .tools .tools.old
fi

git config --global user.name "Quantza"
git config --global user.email "post2base@outlook.com"
git clone git@github.com:Quantza/dotfiles.git

echo "alias qhome='/cygdrive/c/Users/Quantza'" >> dotfiles/.bashrc_custom
echo "alias bhome='/cygdrive/c/Users/TheBoss'" >> dotfiles/.bashrc_custom
echo "alias apt-cyg-main='apt-cyg -m http://mirrors.kernel.org/sourceware/cygwin'" >> dotfiles/.bashrc_custom
echo "alias apt-cyg-port='apt-cyg -m ftp://ftp.cygwinports.org/pub/cygwinports'" >> dotfiles/.bashrc_custom

ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.tmux.conf .
ln -sb dotfiles/.gitmessage.txt .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sb dotfiles/tools.sh .
ln -sf dotfiles/.emacs.d .
ln -sf dotfiles/.tmux .
ln -sf dotfiles/.tools .
ln -sf dotfiles/.vagrant.d .

touch start-agent-trigger

if [ -d .ssh/ ]
then
    cp -R .ssh .ssh.old
    chgrp -Rv Users ~/.ssh/*
    cp dotfiles/.ssh/config ~/.ssh
else
    cp -R dotfiles/.ssh .
    chgrp -Rv Users ~/.ssh/*
    #chmod -vR 644 ~/.ssh/*.pub
fi

chmod -vR 600 ~/.ssh/config
chmod -R 0700 ~/dotfiles/.tools/

