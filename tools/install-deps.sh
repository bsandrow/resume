#!/bin/bash
#
# Sources:
#   - https://gist.github.com/peterhurford/75957ba9335e755013b87254ec85fab1
#

function run() {
    echo "[✨] $@"
    "$@"
}

function die() {
    echo "ERROR: $@" >&2
    exit 1
}

case $OSTYPE in

    darwin*)
        if ! which brew 2>&1 1>/dev/null; then
            die "Failed to find Homebrew in \$PATH"
        fi

        run brew list pandoc 2>&1 1>/dev/null || brew install pandoc
        run brew list --cask basictex 2>&1 1>/dev/null || brew install --cask basictex

        #
        # Update $PATH to include `/usr/local/texlive/2022basic/bin/universal-darwin`
        #
        eval "$(/usr/libexec/path_helper)"
        ;;

    linux*)
        echo "Note: Only tested on Ubuntu 12.10..." >&2
        run sudo apt-get install python-jinja2
        run sudo apt-get install texlive-xetex
        ;;

    *)
        die "Unsupported OS type: $OSTYPE"
        ;;
esac

#
# tlmgr - TeX Live Package Manager
#
function pkgs() {
    cat requirements.txt | sed '/^\s*$/d; /^\s*#/d;' | while read pkg; do
        echo -n "$pkg "
    done
    echo
}

run sudo tlmgr update --self
run sudo tlmgr install $(pkgs)
# cat requirements.txt | sed '/^\s*$/d; /^\s*#/d;' | while read pkg; do
#     run sudo tlmgr install $pkg
# done
