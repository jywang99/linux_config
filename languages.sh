# apt
sudo apt install -y build-essential ripgrep fd-find openjdk-21-jdk unzip

# python
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.10
sudo apt install python3.10
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 0

# NVM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
nvm install 20.5.0
nvm use 20.5.0

# XML
wget https://github.com/redhat-developer/vscode-xml/releases/download/0.26.1/lemminx-linux.zip
unzip lemminx-linux.zip
sudo mv le lemminx-linux /usr/bin/

# dotnet
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt update
rm packages-microsoft-prod.deb
sudo apt-get install -y dotnet-sdk-6.0 # for N* projects
sudo apt-get install -y dotnet-sdk-8.0
# dotnet debug
wget https://github.com/Samsung/netcoredbg/releases/download/3.0.0-1018/netcoredbg-linux-amd64.tar.gz
tar -xvzf netcoredbg-linux-amd64.tar.gz
mv ./netcoredbg/ /usr/lib/
rm netcoredbg-linux-amd64.tar.gz

# Go
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.6.linux-amd64.tar.gz
sudo ln -s /usr/local/go/bin/go /usr/bin/go
rm go1.21.6.linux-amd64.tar.gz

