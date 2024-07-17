#!/bin/bash

# PREREQ: must have ~/bin as a part of PATH
# to add ~/bin as a part of PATH run: PATH="$HOME/bin:$PATH"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$SCRIPT_DIR"/clouduploader.sh "$HOME"/bin/clouduploader
cat "$SCRIPT_DIR"/.env >> "$HOME"/bin/.clouduploaderconfig

sudo chmod +x "$HOME"/bin/clouduploader