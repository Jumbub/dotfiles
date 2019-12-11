if ! pgrep redshift
then
  notify-send Starting redshift
  redshift &
fi

if ! pgrep caffiene
then
  notify-send Starting caffiene
  caffiene &
fi
