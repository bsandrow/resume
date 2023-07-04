#!/bin/bash
#
# Install required OTF/TTF fonts
#

function run() {
    echo "[✨] $@"
    "$@"
}

function copy_fonts() {
    fontdir=$1
    echo "[📦] Installing fonts to '$fontdir'..."
    for FONT in fonts/*/*; do
        echo " -> $(basename $FONT)"
        cp "$FONT" "$fontdir"
    done
}

case $OSTYPE in
    linux-gnu*)

        FONTDIR="${HOME}/.fonts"
        run mkdir -p $FONTDIR
        copy_fonts $FONTDIR
        run fc-cache -fv
        ;;

    darwin*)

        FONTDIR="${HOME}/Library/Fonts"
        run mkdir -p $FONTDIR
        copy_fonts $FONTDIR
        ;;

    *)

        echo "Unsupported \$OSTYPE: ${OSTYPE}" >&2
        exit 1
        ;;
esac