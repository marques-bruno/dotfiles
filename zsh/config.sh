#!/bin/sh

# VI bindings in zsh, sweet...
bindkey -v

# important: start ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# my own custom scripts and binaries are usually in .bin or .bin/scripts
export PATH=.bin/scripts:/home/bruno/.bin:$PATH

# ruby gems
export PATH=/home/bruno/.local/share/gem/ruby/3.0.0/bin:$PATH

# ccache for faster builds
export PATH=/usr/lib/ccache/bin/:$PATH

# ADK scripts path
export PATH=/opt/ADK/:$PATH
export LD_LIBRARY_PATH=/usr/local/lib

# current dlt-viewer install.. for some reason install-prefix is not used during make install command...
export PATH=/home/bruno/dev/tools/dlt-viewer/build/bin:$PATH
