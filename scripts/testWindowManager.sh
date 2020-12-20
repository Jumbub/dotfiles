#!/usr/bin/env zsh

(Xephyr -br -ac -noreset -resizeable :1 &) && sleep 1 && DISPLAY=:1 awesome
