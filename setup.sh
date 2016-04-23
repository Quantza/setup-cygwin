#!/bin/bash
# Simple setup.sh for configuring cygwin,
# for headless setup.

OLDBASEDIR="$PWD"

touch "$HOME"/"cygwin-trigger"

chmod a+x ./setup_init.sh
source ./setup_init.sh

cd "$OLDBASEDIR"

chmod a+x ./setup_version_managers.sh
source 	./setup_version_managers.sh

cd "$OLDBASEDIR"

chmod a+x ./setup_helper.sh
/bin/bash ./setup_helper.sh

cd "$OLDBASEDIR"

