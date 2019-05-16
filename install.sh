#!/bin/bash

bashrc="$HOME/.bashrc"
profile="$HOME/.profile"

# Check .bashrc
if grep -qsE '(source|\.).*\brybash\.sh\b' "$bashrc"; then
	echo ".bashrc already patched"
else
	echo "paching .bashrc ..."
	top=$(readlink -f "${0%/*}")
	[[ $top != ${top#$HOME} ]] && top='$HOME'"${top#$HOME}"
	add=$(cat << EOF

# Include RyBash stuff (interactive & non-interactve)
source "$top/rybash.sh"

EOF
)
	awk -v add="$add" '/\s*#/{print;next}{if(!d) print add; d=1; print}' "$bashrc" > "$bashrc-new" && \
		cp "$bashrc" "$bashrc~" && mv "$bashrc-new" "$bashrc"
fi

if grep -qs '/\.bashrc\b' "$profile"; then
	echo ".profile is OK"
else
	cat << EOF

Check your $profile, add something similar to:

# if running bash
if [ -n "\$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "\$HOME/.bashrc" ]; then
      . "\$HOME/.bashrc"
    fi
fi
EOF
fi

