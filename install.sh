#!/bin/bash
sudo ufw allow ssh
sudo ufw allow www
sudo yes 'yes' | ufw enable

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'

echo -ne "\nName: " && read name
echo -ne "\nEmail: " && read email
echo -e "\n"

mkdir ~/Workspace
ln -s ~/Workspace ~/w

sudo echo 'America/Sao_Paulo' > /etc/timezone

sudo apt-get install zsh git wget curl apt-transport-https -y

echo -e "\nexport NAME=\"$name\"" >> ~/.zshrc
echo -e "\nexport EMAIL=\"$email\"" >> ~/.zshrc

source ~/.zshrc

ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f ~/.ssh/id_rsa -N ''

# dotfiles
wget -NP /tmp http://is.gd/ENw5aL && source /tmp/ENw5aL

git clone https://github.com/powerline/fonts.git ~/fonts
source ~/fonts/install.sh

wget -NP /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sed -i.bak '/env zsh/d' /tmp/install.sh
source /tmp/install.sh
sed -i.bak 's/export\ PATH="/export\ PATH="$PATH:/' ~/.zshrc

git clone https://github.com/zenorocha/dracula-theme/ ~/dracula-theme
ln -s ~/dracula-theme/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
sed -i.bak 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1dracula\2~' ~/.zshrc

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse' | \
    sudo tee /etc/apt/sources.list.d/mongodb-org-3.0.list

curl https://repo.varnish-cache.org/GPG-key.txt | sudo apt-key add -
sudo echo 'deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1' >> \
    /etc/apt/sources.list.d/varnish-cache.list

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo echo -e "\ndeb http://dl.google.com/linux/deb/ stable main" >> /etc/apt/sources.list

sudo add-apt-repository ppa:webupd8team/java -y

sudo apt-get update -y
sudo apt-get install aptitude -y
sudo aptitude update -y

echo 'oracle-java9-installer shared/accepted-oracle-license-v1-1 select true' | \
    sudo /usr/bin/debconf-set-selections
echo 'mysql-server mysql-server/root_password password root' | \
    sudo /usr/bin/debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | \
    sudo /usr/bin/debconf-set-selections

sudo aptitude install build-essential python-dev python3-dev python-setuptools python3-setuptools \
    ipython ipython3 tree exuberant-ctags supervisor nginx postgresql postgresql-contrib golang \
    golang-go.tools redis-server mongodb-org tig python-pip python3-pip ntp varnish p7zip \
    p7zip-full p7zip-rar lzma lzma-dev tmux vim vim-nox indicator-keylock rabbitmq-server \
    ruby pgadmin3 htop sqlite3 libsqlite3-dev oracle-java9-installer oracle-java9-set-default \
    mysql-server libmysqlclient-dev mysql-client mysql-workbench mysql-workbench-data filezilla \
    firefox google-chrome-stable -y

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm
rvm install 2.2.4
rvm --default use current
gem install rubocop

sudo pip2 install --upgrade pip setuptools
sudo pip2 install virtualenv virtualenvwrapper flake8 ipdb httpie argparse

sudo pip3 install --upgrade pip setuptools
sudo pip3 install flake8 ipdb httpie argparse --upgrade

echo -e "\nsource /usr/local/bin/virtualenvwrapper.sh" >> ~/.zshrc

echo -e "\nif [ -f ~/.zsh_aliases ]; then" >> ~/.zshrc
echo -e "    . ~/.zsh_aliases" >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

echo -e "\nif [ -f ~/.zsh_functions ]; then" >> ~/.zshrc
echo -e "    . ~/.zsh_functions" >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

# Vim IDE
wget -NP /tmp http://is.gd/H4WYUh && source /tmp/H4WYUh

# Ubuntu Updater
wget -NP /tmp http://is.gd/qVPryF && source /tmp/qVPryF
source ~/updater.sh

sudo reboot
