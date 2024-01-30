sudo apt install fontconfig
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/UbuntuMono.zip
unzip UbuntuMono.zip -d mono
mkdir ~/.fonts
mv mono/UbuntuMonoNerdFontPropo-Regular.ttf ~/.fonts
rm UbuntuMono.zip
rm -r mono/
fc-cache -fv

