#!/bin/bash
cd ~

echo 'America/Sao_Paulo' > /etc/timezone

sudo locale-gen UTF-8

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee \
    /etc/apt/sources.list.d/mongodb.list

sudo apt-get update -y
sudo apt-get upgrade -y

sudo apt-get install build-essential python-dev python-setuptools python3-setuptools ipython \
    ipython3 tree git exuberant-ctags supervisor nginx postgresql postgresql-contrib golang \
    redis-server mongodb-org tig python-pip python3-pip ntp -y

git config --global push.default simple
git config --global core.editor vim

sudo pip2 install -U setuptools virtualenv virtualenvwrapper flake8 ipdb httpie argparse

echo -e '\nsource /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc

sudo pip3 install -U setuptools flake8 ipdb httpie argparse

git clone https://github.com/rafael84/vim-ide.git
source ~/vim-ide/install.sh
touch ~/.vimrc_extra

git clone https://github.com/powerline/fonts.git
source ~/fonts/install.sh
git clone https://github.com/milkbikis/powerline-shell.git
cp ~/powerline-shell/config.py{.dist,}
cd ~/powerline-shell/ && ./install.py && cd ~
ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py
echo -e '\nfunction _update_ps1() {\n    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"\n}' \
    >> ~/.bashrc
echo -e '\nexport PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"' >> ~/.bashrc
echo -e 'alias python2="python"' >> ~/.bash_aliases
sed -i '1s/.*/#!\/usr\/bin\/env python2/' ~/powerline-shell/powerline-shell.py

git clone https://github.com/fellipecastro/ubuntu-updater.git
cp ~/ubuntu-updater/updater.sh ~

sudo apt-get autoremove -y
sudo apt-get clean -y

sudo reboot
