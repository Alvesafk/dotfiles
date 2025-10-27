#!/bin/bash
# Script: allinstall.sh
# Description: Install all the important aplications (to me)

choiceCheck() {
  declare -n choice=$1

  while ! [[ $choice =~ ^[1-2]$ ]]; do 
    read -p "Error! 1 for yes | 2 for no: " choice
  done
}

main () {
  if ! command -v git >/dev/null 2>&1; then
    sudo pacman -S --noconfirm git
  fi

  echo "-=- All-Install -=-"

  if grep -Eq '^\s*#?\s*\[multilib\]' "/etc/pacman.conf"; then
    echo "The section multilib is already in pacman.conf. No modifications made"
  else 
    read -p "The section multilib is NOT in pacman.conf. Want to add it? 1 for yes | 2 for no: " secChoice
    choiceCheck secChoice

    if [[ $secChoice -eq 1 ]]; then
      echo | sudo tee -a "$PACMAN_CONF" > /dev/null
      echo "[multilib]" | sudo tee -a "$PACMAN_CONF" > /dev/null
      echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a "$PACMAN_CONF" > /dev/null
      
      echo "The section multilib was ADDED in pacman.conf."

      sudo pacman -Sy

      sudo pacman -S --noconfirm nvim tmux discord thunderbird firefox kitty steam
    fi 

    sudo pacman -S --noconfirm nvim tmux discord thunderbird firefox kitty
  fi 

  echo "The section multilib was NOT ADDED in pacman.conf."

  unset secChoice
}
