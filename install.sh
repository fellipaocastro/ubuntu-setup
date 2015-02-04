#!/bin/bash
cd ~

sudo locale-gen UTF-8

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get autoremove -y
sudo apt-get clean -yi

sudo apt-get install python-dev python-setuptools python3-setuptools ipython ipython3 \
tree git exuberant-ctags supervisor nginx postgresql postgresql-contrib -y

sudo easy_install -U pip

sudo apt-get install python3-pip -y

sudo pip install --upgrade setuptools pip
sudo pip3 install --upgrade setuptools pip

sudo pip install virtualenv virtualenvwrapper flake8 ipdb httpie argparse

sudo pip3 install flake8 ipdb httpie argparse

git config --global push.default simple
git config --global core.editor vim

git clone https://github.com/rafael84/vim-ide.git
bash ~/vim-ide/install.sh
touch ~/.vimrc_extra

git clone https://github.com/powerline/fonts.git
./fonts/install.sh
git clone https://github.com/milkbikis/powerline-shell.git
cp powerline-shell/config.py{.dist,}
cd powerline-shell/ && ./install.py && cd ..
ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py


echo -e '\nfunction _update_ps1() {\n    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"\n}' >> ~/.bashrc

echo -e '\nexport PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"' >> ~/.bashrc

echo -e '\nsource /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc

echo -e 'alias python2="python"' >> ~/.bash_aliases

sed -i '1s/.*/#!\/usr\/bin\/env python2/' ~/powerline-shell/powerline-shell.py

git clone https://github.com/fellipecastro/ubuntu-updater.git
cp ubuntu-updater/updater.sh ~
