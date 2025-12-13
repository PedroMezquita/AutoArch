#/usr/bin/env bash

echo "[Configure Keyboard]"
PS3='Choose Layout'
options="$(localectl list-keymaps)"

select layout in "${options[@]}"
do
echo "aaa"
done
