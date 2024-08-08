#!/bin/sh

# my own custom scripts and binaries are usually in .bin or .bin/scripts
export PATH=.bin/scripts:/home/bruno/.bin:$PATH

# ruby gems
export PATH=/home/bruno/.local/share/gem/ruby/3.0.0/bin:$PATH

# ccache for faster builds
export PATH=/usr/lib/ccache/bin/:$PATH
