#!/bin/bash
#
# Sources:
#   - https://gist.github.com/peterhurford/75957ba9335e755013b87254ec85fab1
#

function die() {
    echo "ERROR: $@" >&2
    exit 1
}

case $OSTYPE in

    darwin*)
        if ! which brew 2>&1 1>/dev/null; then
            die "Failed to find Homebrew in \$PATH"
        fi

        brew list pandoc 2>&1 1>/dev/null || brew install pandoc
        brew list --cask basictex 2>&1 1>/dev/null || brew install --cask basictex

        #
        # Update $PATH to include `/usr/local/texlive/2022basic/bin/universal-darwin`
        #
        eval "$(/usr/libexec/path_helper)"
        ;;

    linux*)
        echo "Note: Only tested on Ubuntu 12.10..." >&2
        sudo apt-get install python-jinja2
        sudo apt-get install texlive-xetex
        ;;

    *)
        die "Unsupported OS type: $OSTYPE"
        ;;
esac

#
# tlmgr - TeX Live Package Manager
#
sudo tlmgr update --self
sudo tlmgr install texliveonfly
sudo tlmgr install xelatex
sudo tlmgr install adjustbox
sudo tlmgr install tcolorbox
sudo tlmgr install collectbox
sudo tlmgr install ucs
sudo tlmgr install environ
sudo tlmgr install trimspaces
sudo tlmgr install titling
sudo tlmgr install enumitem
sudo tlmgr install rsfs

#
# tlmgr - additional packages used by resume.tex
#
sudo tlmgr install marvosym
sudo tlmgr install titlesec
