if ! command -v git >/dev/null 2>&1; then
  sudo pacman -S --noconfirm git
fi 
sudo pacman -S tmux
rm -rf .config/tmux
cp -r ../tmux ~/.config
