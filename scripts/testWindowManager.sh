#!/usr/bin/env zsh

if pgrep Xephyr
then
  DISPLAY=:1 awesome --replace
else
  (Xephyr -br -ac -noreset -screen 1280x720 :1 &) && sleep 1 && DISPLAY=:1 awesome &
fi
