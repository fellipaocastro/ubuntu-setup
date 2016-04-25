#!/bin/bash
echo -ne '\nName: ' && read name
echo -ne '\nEmail: ' && read email
echo ''

sudo ufw allow ssh
sudo ufw allow www
sudo yes 'yes' | ufw enable

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'

mkdir ~/Workspace
ln -s ~/Workspace ~/w

sudo echo 'America/Sao_Paulo' > /etc/timezone

sudo apt-get install zsh git wget curl apt-transport-https -y

# dotfiles
wget -NP /tmp http://is.gd/ENw5aL && source /tmp/ENw5aL

git clone https://github.com/powerline/fonts.git ~/fonts
source ~/fonts/install.sh

wget -NP /tmp https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh
sed -i.bak '/env zsh/d' /tmp/install.sh
source /tmp/install.sh
sed -i.bak 's/export\ PATH="/export\ PATH="$PATH:/' ~/.zshrc

echo -e "\nexport NAME=\"$name\"" >> ~/.zshrc
echo -e "export EMAIL=\"$email\"" >> ~/.zshrc

git config --global user.name "$name"
git config --global user.email "$email"

ssh-keygen -t rsa -b 4096 -C "$email" -f ~/.ssh/id_rsa -N ''

git clone https://github.com/zenorocha/dracula-theme/ ~/dracula-theme
ln -s ~/dracula-theme/zsh/dracula.zsh-theme ~/.oh-my-zsh/themes/dracula.zsh-theme
sed -i.bak 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1dracula\2~' ~/.zshrc

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/zsh-syntax-highlighting
echo -e '\nsource ~/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc

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

echo 'oracle-java8-installer shared/accepted-oracle-license-v1-1 select true' | \
    sudo /usr/bin/debconf-set-selections
echo 'mysql-server mysql-server/root_password password root' | \
    sudo /usr/bin/debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password root' | \
    sudo /usr/bin/debconf-set-selections

sudo aptitude install build-essential python-dev python3-dev python-setuptools python3-setuptools \
    python-pip python3-pip ipython ipython3 tree exuberant-ctags supervisor nginx postgresql \
    golang-go.tools redis-server mongodb-org tig python-pip python3-pip ntp varnish p7zip \
    p7zip-full p7zip-rar lzma lzma-dev tmux vim vim-nox indicator-keylock rabbitmq-server \
    ruby pgadmin3 htop sqlite3 libsqlite3-dev oracle-java8-installer oracle-java8-set-default \
    mysql-server libmysqlclient-dev mysql-client mysql-workbench mysql-workbench-data filezilla \
    firefox google-chrome-stable postgresql-contrib golang -y

sudo pip2 install -U pip setuptools
sudo pip2 install -U virtualenv virtualenvwrapper flake8 ipdb httpie argparse thefuck

sudo pip3 install -U pip setuptools
sudo pip3 install -U flake8 ipdb argparse

echo -e '\nsource /usr/local/bin/virtualenvwrapper.sh' >> ~/.zshrc

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | bash -s stable
source /usr/local/rvm/scripts/rvm
rvm install 2.2.4
rvm --default use current
gem install rubocop

echo -e '\nif [ -f ~/.zsh_aliases ]; then' >> ~/.zshrc
echo -e '    . ~/.zsh_aliases' >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

echo -e '\nif [ -f ~/.zsh_functions ]; then' >> ~/.zshrc
echo -e '    . ~/.zsh_functions' >> ~/.zshrc
echo -e 'fi' >> ~/.zshrc

echo -e '\neval $(thefuck --alias)' >> ~/.zshrc

# Vim IDE
wget -NP /tmp http://is.gd/H4WYUh && source /tmp/H4WYUh

# Updater
wget -NP /tmp http://is.gd/yDgV6m && source /tmp/yDgV6m
source ~/updater.sh

source ~/.zshrc

sudo reboot
