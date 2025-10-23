if ! command -v git >/dev/null 2>&1; then
  sudo pacman -S --noconfirm git
fi
sudo pacman -S kitty
rm -rf ~/.config/kitty
cp ../kitty ~/.config
