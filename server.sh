{\rtf1\ansi\ansicpg1252\cocoartf1343\cocoasubrtf160
{\fonttbl\f0\fnil\fcharset0 HelveticaNeue;\f1\fmodern\fcharset0 Courier;}
{\colortbl;\red255\green255\blue255;}
\paperw11900\paperh16840\margl1440\margr1440\vieww14400\viewh9600\viewkind0
\deftab720
\pard\pardeftab720\sl320

\f0\fs24 \cf0 \expnd0\expndtw0\kerning0
#!/bin/bash\
cd ~\
\
sudo locale-gen UTF-8\
\
for i in \{1..2\}\
do\
\'a0 \'a0 sudo apt-get update -y\
\'a0 \'a0 sudo apt-get upgrade -y\
\'a0 \'a0 sudo apt-get autoremove -y\
\'a0 \'a0 sudo apt-get clean -y\
done\
\
sudo apt-get install python-setuptools python3-setuptools -y\
\
sudo easy_install -U pip\
\
sudo apt-get install python3-pip -y\
\
for i in \{1..2\}\
do\
\'a0 \'a0 sudo pip install --upgrade setuptools pip\
\'a0 \'a0 sudo pip3 install --upgrade setuptools pip\
done\
\
sudo apt-get install python-dev tree git exuberant-ctags supervisor nginx postgresql \\\
postgresql-contrib -y\
\
sudo pip install virtualenv virtualenvwrapper ipython flake8 ipdb httpie argparse\
\
sudo pip3 install ipython flake8 ipdb httpie argparse\
\
git config --global user.name \'93Fellipe Castro\'94\
git config --global user.email contact@fellipecastro.com\
git config --global push.default simple\
git config --global core.editor vim\
\
if [ ! -f ~/.ssh/id_rsa.pub ]; then\
\pard\pardeftab720\sl320

\f1 \cf0 \expnd0\expndtw0\kerning0
	ssh-keygen -t rsa -C "contact@fellipecastro.com\'94\
\pard\pardeftab720\sl320
\cf0 \expnd0\expndtw0\kerning0
	cat .ssh/id_rsa.pub\expnd0\expndtw0\kerning0
\
\pard\pardeftab720\sl320

\f0 \cf0 \expnd0\expndtw0\kerning0
	read -p \'91Press [Enter] key to continue\'85\'92\
fi\
\
\pard\pardeftab720\sl320

\f1 \cf0 \expnd0\expndtw0\kerning0
wget -O - https://raw.githubusercontent.com/rafael84/vim-ide/master/install.sh | bash\
touch ~/.vimrc_extra\
\
git clone git@github.com:powerline/fonts.git\
./fonts/install.sh\
git clone git@github.com:milkbikis/powerline-shell.git\
cp powerline-shell/config.py\{.dist,\}\
cd powerline-shell/ && ./install.py && cd ..\
ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py
\f0 \expnd0\expndtw0\kerning0
\
\
\
echo -e '\\nfunction _update_ps1() \{\\n    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"\\n\}' >> ~/.bashrc\
\
echo -e \'91\\n
\f1 \expnd0\expndtw0\kerning0
export PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND\'94\'92 >> ~/.bashrc
\f0 \expnd0\expndtw0\kerning0
\
\
echo -e \'91\\n
\f1 \expnd0\expndtw0\kerning0
source /usr/local/bin/virtualenvwrapper.sh\'92 >> ~/.bashrc\
\
echo -e \'91alias python2=\'93python\'94\'92 > ~/.bash_aliases\
\
sed -i '' '1s/.*/#!\\/usr\\/bin\\/env python2/' ~/powerline-shell/powerline-shell.py\
\
git clone git@github.com:fellipecastro/ubuntu-updater.git\
cp ubuntu-updater/updater.sh ~\
\
source ~/.bashrc\
\pard\pardeftab720\sl320

\f0 \cf0 \expnd0\expndtw0\kerning0
\
cd -}