#!/bin/bash
#

VENV=".venv"

function run() {
    echo "[✨] $@"
    "$@"
}

if [[ ! -d "$VENV" ]]; then
    run python3 -m virtualenv "$VENV"
fi
run source "$VENV/bin/activate"
run pip install jinja2