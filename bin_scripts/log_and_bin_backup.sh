#!/bin/bash

OPTION="0"

if [ $# -lt "1" ]
	then
	    echo "Backing up to local dir only"
		exit 1
else
	echo "Backing up to local dir and provided file path."
	OPTION="1"
fi


# Same drive, keystore Backup dir
PATH_PREFIX="$HOME/Docs"
PATH_INFIX="/LinuxScripts"
PATH_LOG_SUFFIX="/logs_and_binaries"
TOTAL_PATH=$("$PATH_PREFIX""$PATH_INFIX""$PATH_SUFFIX")

if [ ! -d $PATH_PREFIX ]; then
    mkdir $PATH_PREFIX
	if [ ! -d "$PATH_PREFIX""$PATH_INFIX" ]; then
		mkdir "$PATH_PREFIX""$PATH_INFIX"
		if [ ! -d $TOTAL_PATH ]; then
			mkdir $TOTAL_PATH
		fi
	fi
fi

cp -r $HOME/logs $TOTAL_PATH
cp -r $HOME/bin $TOTAL_PATH

if [ $OPTION -eq "0" ]
	echo "Backed up to local dir!"
	exit 1
fi

# User provided, keystore Backup dir
LINK_OR_DIR=$1

if [ ! -d "$LINK_OR_DIR" ]; then
    mkdir "$LINK_OR_DIR"
fi

USER_DIR_SUFFIX=$("$PATH_INFIX""$PATH_SUFFIX")

#For symbolic links and hard links/directories
#Double quotes protects spaces in variable substitution.
if [ -d "$LINK_OR_DIR" ]; then 
  if [ -L "$LINK_OR_DIR" ]; then
    # It is a symlink!
    # Symbolic link specific commands go here.
    cp -r ~/logs $(readlink "$LINK_OR_DIR")$USER_DIR_SUFFIX
	cp -r ~/bin $(readlink "$LINK_OR_DIR")$USER_DIR_SUFFIX
  else
    # It's a directory!
    # Directory command goes here.
    cp -r ~/logs "$LINK_OR_DIR"$USER_DIR_SUFFIX
	cp -r ~/bin "$LINK_OR_DIR"$USER_DIR_SUFFIX
  fi
fi

echo "Done!"

