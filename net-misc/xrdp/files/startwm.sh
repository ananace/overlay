#!/bin/sh

# try hard to respect Gentoo's wm choice
. /etc/profile
[ -f /etc/rc.conf ] && . /etc/rc.conf
export XSESSION

USERINITRC="$HOME/.xinitrc"
if [ -f "$USERINITRC" ]; then
    . "$USERINITRC"
else
    . /etc/X11/xinit/xinitrc
fi
