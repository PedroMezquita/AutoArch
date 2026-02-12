#!/bin/bash

CONFIG_FILE=$(realpath "configuration.conf")
SCRIPT_FOLDER=$(realpath "scripts")

$SCRIPT_FOLDER"/install-base.sh" $CONFIG_FILE
source $CONFIG_FILE
if [ $POST_INSTALL_FLAG ]; then
  cp $SCRIPT_FOLDER"/post-install.sh" /mnt/
  cp $CONFIG_FILE /mnt/
  arch-chroot /mnt /post-install.sh "/configuration.conf"
  rm /mnt/post-install.sh /mnt/configuration.conf
fi
if [ $POST_INSTALL_CONFIG_FLAG ]; then
  cp $SCRIPT_FOLDER"/post-install-config.sh" /mnt/
  cp $CONFIG_FILE /mnt/
  arch-chroot /mnt /post-install-config.sh "/configuration.conf"
  rm /mnt/post-install-config.sh /mnt/configuration.conf
fi

reboot
