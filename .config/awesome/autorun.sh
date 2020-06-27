#!/usr/bin/env zsh

run="$HOME/scripts/run-if-not"

$run "/usr/lib/mate-polkit/polkit-mate-authentication-agent-1" "polkit-mate-aut"

$run --notify "start-pulseaudio-x11" "pulseaudio"
$run --notify "xfsettingsd"
$run --notify "nm-applet"
$run --notify "thunar --daemon" "thunar"
$run --notify "msm_notifier"
$run --notify "pa-applet"
$run --notify "redshift"
$run --notify "pamac-tray"
$run --notify "greenclip daemon" "greenclip"

if [ "`$HOME/scripts/theme`" = "maximal" ]
then
  $run --notify "compton"
fi

