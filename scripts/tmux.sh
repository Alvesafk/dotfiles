if ! command -v git >/dev/null 2>&1; then
  sudo pacman -S --noconfirm git
fi 
sudo pacman -S tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cp -r ../tmux ~/.config
