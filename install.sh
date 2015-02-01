#!/bin/bash
cd ~

sudo locale-gen UTF-8

for i in {1..2}
do
    sudo apt-get update -y
    sudo apt-get upgrade -y
    sudo apt-get autoremove -y
    sudo apt-get clean -y
done

sudo apt-get install python-setuptools python3-setuptools -y

sudo easy_install -U pip

sudo apt-get install python3-pip -y

for i in {1..2}
do
    sudo pip install --upgrade setuptools pip
    sudo pip3 install --upgrade setuptools pip
done

sudo apt-get install python-dev tree git exuberant-ctags supervisor nginx postgresql \
postgresql-contrib -y

sudo pip install virtualenv virtualenvwrapper ipython flake8 ipdb httpie argparse

sudo pip3 install ipython flake8 ipdb httpie argparse

git config --global user.name "Fellipe Castro"
git config --global user.email contact@fellipecastro.com
git config --global push.default simple
git config --global core.editor vim

if [ ! -f ~/.ssh/id_rsa.pub ]; then
    ssh-keygen -t rsa -C "contact@fellipecastro.com"
    cat .ssh/id_rsa.pub
    read -p 'Press [Enter] key to continue…'
fi

git clone git@github.com:rafael84/vim-ide.git
bash ~/vim-ide/install.sh
touch ~/.vimrc_extra

git clone git@github.com:powerline/fonts.git
./fonts/install.sh
git clone git@github.com:milkbikis/powerline-shell.git
cp powerline-shell/config.py{.dist,}
cd powerline-shell/ && ./install.py && cd ..
ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py


echo -e '\nfunction _update_ps1() {\n    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"\n}' >> ~/.bashrc

echo -e '\nexport PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"' >> ~/.bashrc

echo -e '\nsource /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc

echo -e 'alias python2="python"' > ~/.bash_aliases

sed -i '1s/.*/#!\/usr\/bin\/env python2/' ~/powerline-shell/powerline-shell.py

git clone git@github.com:fellipecastro/ubuntu-updater.git
cp ubuntu-updater/updater.sh ~

source ~/.bashrc

cd -
