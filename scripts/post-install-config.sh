#!/bin/bash

source $1
echo "Temporarilly enabling passwordless sudo for user $ADMIN_USERNAME..."
echo "$ADMIN_USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

echo "[Post-Install configuration]"
if [ $GIT_DOTFILES ]; then
  echo "Checking for git..."
  pacman -Syu --needed --noconfirm git
  echo "Cloning github..."
  runuser -l $ADMIN_USERNAME -c "git clone --bare $GIT_DOTFILES /home/$ADMIN_USERNAME/.cfg"
  runuser -l $ADMIN_USERNAME -c "/usr/bin/git \
                              --git-dir=/home/$ADMIN_USERNAME/.cfg \
                              --work-tree=/home/$ADMIN_USERNAME\
                              config --local status.showUntrackedFiles no"

  runuser -l $ADMIN_USERNAME -c "/usr/bin/git \
                              --git-dir=/home/$ADMIN_USERNAME/.cfg \
                              --work-tree=/home/$ADMIN_USERNAME\
                              checkout -f"
  echo "Creating config alias..."
  runuser -l $ADMIN_USERNAME -c "echo \"alias config='/usr/bin/git \
                              --git-dir=/home/$ADMIN_USERNAME/.cfg \
                              --work-tree=/home/$ADMIN_USERNAME'\" \
                              >> /home/$ADMIN_USERNAME/.bashrc"  
fi

echo "Reverting passwordless sudo for user $ADMIN_USER..."
sed -i "s/$ADMIN_USERNAME ALL=(ALL:ALL) NOPASSWD: ALL//g" /etc/sudoers
