#!/usr/bin/env bash
killall -q polybar
for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar --log=error 2>&1 > /tmp/polybar-$m.log & disown
done
