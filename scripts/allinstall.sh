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
  echo "-=- All-Install -=-"
  sleep 2

  sudo pacman -Sy

  if ! command -v git >/dev/null 2>&1; then
    sudo pacman -S --noconfirm git
  fi

  # Multilib shenanigans
  if grep -Eq '^\s*#?\s*\[multilib\]' "/etc/pacman.conf"; then
    echo "The section multilib is already in pacman.conf. No modifications made"
    sleep 1

    echo "Installing applications."
    sleep 1
    sudo pacman -S --noconfirm nvim tmux discord thunderbird firefox kitty steam

  else
    read -p "The section multilib is NOT in pacman.conf. Want to add it? 1 for yes | 2 for no: " secChoice
    choiceCheck secChoice

    if [[ $secChoice -eq 1 ]]; then
      echo | sudo tee -a "$PACMAN_CONF" > /dev/null
      echo "[multilib]" | sudo tee -a "$PACMAN_CONF" > /dev/null
      echo "Include = /etc/pacman.d/mirrorlist" | sudo tee -a "$PACMAN_CONF" > /dev/null
      
      echo "The section multilib was ADDED in pacman.conf."
      sleep 2

      sudo pacman -Sy

      sudo pacman -S --noconfirm nvim tmux discord thunderbird firefox kitty steam
    else 
      echo "The section multilib was NOT ADDED in pacman.conf."
      sleep 2

      sudo pacman -S --noconfirm nvim tmux discord thunderbird firefox kitty
    fi 
  fi 

  unset secChoice

  # AUR helper installation
  read -p "Do you want to install a AUR helper? 1 for yay | 2 for paru: " aurChoice
  choiceCheck aurChoice

  aur=0

  sudo pacman -S --needed --noconfirm base-devel

  if [[ aurChoice -eq 1 ]]; then
    echo "Installing yay"

    mkdir ~/gitclones
    git clone https://aur.archlinux.org/yay.git ~/gitclones/yay
    (cd ~/gitclones/yay && makepkg -si)
    aur=yay
  else
    echo "Installing paru"

    mkdir ~/gitclones
    git clone https://aur.archlinux.org/paru.git ~/gitclones/paru
    (cd ~/gitclones/paru && makepkg -si)
    aur=paru
  fi

  echo "Your AUR helper is installed!"
  sleep 2

  unset aurChoice

  # Tmux config install
  echo "Configuring tmux"
  sleep 1
  cp -r ../tmux ~/.config
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # Nvim config install
  echo "Configuring neovim"
  sleep 1
  cp -r ../nvim ~/.config/

  # Kitty config install
  echo "Configuring kitty"
  sleep 1
  cp -r ../kitty ~/.config

  # Fish config install
  echo "Configurin fish"
  sleep 1
  cp -r ../fish ~/.config
  curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

  # Hyprland config
  read -p "Using hyprland? Want to install my config? 1 for yes | 2 for no: " hyprChoice
  choiceCheck hyprChoice

  if [[ $hyprChoice -eq 1 ]]; then
    echo "Installing the hyprland config."
    sleep 2

    sudo pacman -S --noconfirm hyprland wofi waybar hyprpaper
    
    $aur -S --noconfirm jq grim slurp wl-clipboard libnotify hyprpicker 

    cp ../hypr ~/.config && cp ../wofi ~/.config && cp ../waybar ~/.config

    echo "Hyprland config is installed."
    sleep 2
  else
    echo "Hyprland config will NOT be installed."
    sleep 2
  fi

  echo "-=- All-install it's finished -=-"
}

main
