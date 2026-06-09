if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    export XCURSOR_SIZE=16
    exec startx
fi
