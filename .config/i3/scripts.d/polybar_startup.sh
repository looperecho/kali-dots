#!/bin/bash

# Startup polybar correctly when reloading i3

# Quit current instance
/usr/bin/polybar-msg cmd quit

# Run
/usr/bin/polybar &
