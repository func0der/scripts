#!/bin/bash

# Source the base path configuration file.
if [ -z $SCRIPTS_GIT_BASE_PATH ]; then
	THIS_FILE_DIR=$(dirname $BASH_SOURCE[0])
	. "${THIS_FILE_DIR}/.bash_paths"
fi

# Source git-prompt.sh
. $SCRIPTS_GIT_BASE_PATH/git-prompt.sh
# To see, what the following variables course, please have a look at the git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWCOLORHINTS=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_DESCRIBE_STYLE=branch
GIT_PS1_SHOWSTASHSTATE=true
# Rewrite the prompt output
PROMPT_COMMAND='__git_ps1 "${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "\\\$ " " [%s]"'
