#!/bin/bash
# Script: gitconfig.sh
# Description: configures your git application

choiceCheck() {
  declare -n choice=$1

  while ! [[ $choice =~ ^[1-2]$ ]]; do 
    read -p "Error! 1 for yes | 2 for no: " choice
  done
}

main() {
  if ! command -v git >/dev/null 2>&1; then
    sudo pacman -S --noconfirm git
  fi
  echo "---Git Config---"

  read -p "What's your name? " name
  git config --global --replace-all user.name "$name"
  echo "Git username is defined as: $name."
  #free the name variable
  unset name

  echo " "

  read -p "What's your email? " email
  git config --global --replace-all user.email "$email"
  echo "Git email is defined as: $email."
  #won't unset the email because it can be used to another config

  echo " "

  #making sure the user choose a valid option
  read -p "You want to specify a default editor? 1 for yes | 2 for no: " editorChoice 
  choiceCheck editorChoice

  if [[ $editorChoice -eq 1 ]]
  then
    read -p "What's your default editor? " defaultEditor
    defaultEditor="${defaultEditor,,}"
    git config --global --replace-all core.editor "$defaultEditor"
    echo "Default editor is defined as: $defaultEditor."
  fi 
  #but will unset here
  unset editorChoice
  unset defaultEditor
  
  echo " "

  read -p "You want to change the default branch name? 1 for yes | 2 for no: " branchChoice
  choiceCheck branchChoice

  if [[ $branchChoice -eq 1 ]]
  then
    read -p "What name do you want to give the default branch? " defaultBranch
    defaultBranch="${defaultBranch,,}"
    git config --global init.defaultBranch "$defaultBranch"
    echo "Default branch is defined as: $defaultBranch."
  fi 

  unset branchChoice
  unset defaultBranch

  echo " "

  echo "WARNING! The ssh config, will remove any existing ssh key that you have in your computer. You've been warned."
  read -p "Want to configure a ssh key? 1 for yes | 2 for no: " sshChoice 
  choiceCheck sshChoice

  if [[ $sshChoice -eq 1 ]]
  then
    rm -rf ~/.ssh
    read -p "Do you want to use the same email that was used in the git config? 1 for yes | 2 for no: " emailChoice 
    choiceCheck emailChoice

    if [[ $emailChoice -eq 1 ]]
    then
      ssh-keygen -t ed25519 -C ""$email""

      unset email
    else
      read -p "Enter the email that you want to use: " email 

      ssh-keygen -t ed25519 -C ""$email""

      unset email
    fi 
    
    eval "$(ssh-agent -s)"

    ssh-add ~/.ssh/id_ed25519

    echo "Now add the SSH public key to your account on Github."
    sleep 2
  fi
  
  echo "Thanks for using Git Config!"
  echo "---Git Config end---"
  return 0
}

main
