if ! command -v git >/dev/null 2>&1; then
  sudo pacman -S --noconfirm git
fi
sudo pacman -S --noconfirm neovim
rm -rf ~/.config/nvim
cp -r ../nvim ~/.config/
