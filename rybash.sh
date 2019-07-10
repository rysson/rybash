# Make sure, that your $HOME/.bashrc has a line:
# source $HOME/.local/share/rybash/bashrc.add.sourced
#
# (c) by Robert Kalinowski <robert.kalinowski@sharkbits.com>

# Default config
source $(dirname "${BASH_SOURCE[0]}")/env
export RYBASH
# always reinitialize
_rybash_initialized=

rybash()
{
	if [[ ! $_rybash_initialized ]]; then
		source "$RYBASH/env"
		source "$RYBASH/functions"
	fi
	[[ $# = 0 ]] && return
	local cmd="$1"
	shift
	rybash-$cmd "$@"
}
export -f rybash

source "$RYBASH/functions"

# If not running interactively, don't do anything
case $- in
	# Interactive, load default modules
	*i*) source "$RYBASH_SOURCE_D/__init__.sh" ;;
esac

# vim:ft=bash:
