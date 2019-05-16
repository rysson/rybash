# Make sure, that your $HOME/.bashrc has a line:
# source $HOME/.local/share/rybash/bashrc.add.sourced
#
# (c) by Robert Kalinowski <robert.kalinowski@sharkbits.com>

# Default config
source ${BASH_SOURCE[0]%/*}/env
export RYBASH

source "$RYBASH/functions"

# If not running interactively, don't do anything
case $- in
	# Interactive, load default modules
	*i*) source "$RYBASH_SOURCE_D/__init__.sh" ;;
esac

