#!/bin/bash
# Simple setup.sh for configuring cygwin,
# for headless setup.

touch "$HOME"/"cygwin-trigger"

chmod a+x ./setup_init.sh
source ./setup_init.sh

chmod a+x ./setup_version_managers.sh
source 	./setup_version_managers.sh

chmod a+x ./setup_helper.sh
/bin/bash ./setup_helper.sh


