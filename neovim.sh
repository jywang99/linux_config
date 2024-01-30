wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz
tar -xvzf nvim-linux64.tar.gz
sudo mv nvim-linux64/ /usr/lib/
sudo ln -s /usr/lib/nvim-linux64/bin/nvim /usr/bin/nvim
rm nvim-linux64.tar.gz

git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone git@github.com:jywang99/neovim.git ~/.config/nvim
