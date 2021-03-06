# Make sure, that your $HOME/.bashrc has a line:
# source $HOME/.local/share/rybash/bashrc.add.sourced
#
# (c) by Robert Kalinowski <robert.kalinowski@sharkbits.com>

# More bash settings
_shopt=$(shopt -p nullglob)
shopt -s nullglob
for f in "$RYBASH_SOURCE_D"/[^_]*; do
	case "$f" in
		README*.md|*/README*.md) ;;
		*) source "$f" ;;
	esac
done
$_shopt  # restore nullglob

# vim:ft=bash:
