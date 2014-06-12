#!/bin/bash

scaling_factor_path='org.cinnamon.desktop.interface scaling-factor'

if [[ $(gsettings get $scaling_factor_path) == 'uint32 1' ]]; then
    gsettings set $scaling_factor_path 2
else
    gsettings set $scaling_factor_path 1
fi
DISPLAY=:0
cinnamon --replace > /dev/null 1>&2 &
