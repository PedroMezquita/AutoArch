#!/bin/bash


echo "[Entering post-install]"
# Checking for AUR

source $1

echo "Temporarilly enabling passwordless sudo for user $ADMIN_USERNAME..."
echo "$ADMIN_USERNAME ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

if [[ $AUR_WRAPPER ]]; then
  case $AUR_WRAPPER in
    "yay")
      echo "Installing yay as $ADMIN_USERNAME..."
      pacman -Syu --needed --noconfirm git base-devel
      runuser -l $ADMIN_USERNAME -c 'git clone https://aur.archlinux.org/yay.git
                                      cd yay
                                      makepkg -si --noconfirm'
  esac
fi



echo "[Installing all the packages...]"
post_install_pkgs=($DISPLAY_SERVER $DESKTOP_ENV $DISPLAY_MANAGER $TEXT_EDITOR $TERM $BROWSER ${ADDITIONAL_PACKAGES[@]})
post_install_pkgs_aur=($DISPLAY_SERVER_AUR $DESKTOP_ENV_AUR $DISPLAY_MANAGER_AUR $TEXT_EDITOR_AUR $TERM_AUR $BROWSER_AUR ${ADDITIONAL_PACKAGES_AUR[@]})
pacman -Syu --needed --noconfirm ${post_install_pkgs[@]}
runuser -l $ADMIN_USERNAME "$AUR_WRAPPER -Syu --noconfirm ${post_install_pkgs_aur[@]}"
if [ $DISPLAY_MANAGER ]; then
  systemctl enable $DISPLAY_MANAGER
elif [ $DISPLAY_MANAGER_AUR ]; then
  systemctl enable $DISPLAY_MANAGER_AUR
fi

echo "Reverting passwordless sudo for user $ADMIN_USER..."
sed -i "s/$ADMIN_USERNAME ALL=(ALL:ALL) NOPASSWD: ALL//g" /etc/sudoers
