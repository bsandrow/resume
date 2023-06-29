#!/bin/bash
#
# Install required OTF/TTF fonts
#

case $OSTYPE in
    linux-gnu*)

        echo "Installing fonts..."
        FONTDIR="${HOME}/.fonts"
        mkdir -p $FONTDIR
        cp -v fonts/*/* $FONTDIR/
        fc-cache -fv
        ;;

    darwin*)

        echo "Installing fonts..."
        FONTDIR="${HOME}/Library/Fonts"
        mkdir -p $FONTDIR
        cp -v fonts/*/* $FONTDIR/
        ;;

    *)

        echo "Unsupported \$OSTYPE: ${OSTYPE}" >&2
        exit 1
        ;;
esac