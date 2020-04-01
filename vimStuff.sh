# some need to be ran in super user

cd ~/Downloads/
curl -sL install-node.now.sh/lts | sh
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

# neovim plugin dependencies
sudo pacman -S python2-pip
python2 -m pip install --user --upgrade pynvim

sudo pacman -S python-pip
python3 -m pip install --user --upgrade pynvim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

run in vim
:PlugInstall


# install plugins from init.vim
# coc-settings.json

# coursier - pure scala artifact fetching
cd ~/Installs/
curl -Lo coursier https://git.io/coursier-cli && chmod +x coursier && ./coursier --help

sudo ./coursier bootstrap \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  --java-opt -Dmetals.client=coc.nvim \
  org.scalameta:metals_2.12:0.7.6 \
  -r bintray:scalacenter/releases \
  -r sonatype:snapshots \
  -o /usr/local/bin/metals-vim -f

# after all npm installations
sudo npm install -g neovim
sudo gem install neovim
sudo gem environment