#!/usr/bin/env bash

update=$1

echo 'Bootstrap started...'

echo 'Create symbolic links for $HOME configuration files'

echo 'Bash configuration files'
if [ -e $HOME/.bashrc ]; then rm $HOME/.bashrc; fi
if ! [ -e $HOME/.bashrc ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.bashrc $HOME/.; fi
if [ -e $HOME/.bash_profile ]; then rm $HOME/.bash_profile; fi
if ! [ -e $HOME/.bash_profile ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.bash_profile $HOME/.; fi
if [ -e $HOME/.profile ]; then rm $HOME/.profile; fi
if ! [ -e $HOME/.profile ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.profile $HOME/.; fi

echo 'VIM configuration files'
if ! [ -e $HOME/.vim ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.vim $HOME/.; fi
if ! [ -e $HOME/.vimrc ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.vimrc $HOME/.; fi

echo 'TMUX configuration files'
if ! [ -e $HOME/.tmux.conf ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.tmux.conf $HOME/.; fi

# Update system
if [ "$update" == 'true' ] 
then 
    echo 'Update system'
    sudo apt-get update
    echo 'Upgrade system'
    sudo apt-get -y upgrade
fi

# Install RVM
if ! rvm_loc="$(type -p rvm)" || [ -z "$rvm_loc" ]; then
    echo 'RVM install'
    \curl -sSL https://get.rvm.io | bash -s stable;
else
    echo 'RVM already installed'
fi
echo 'RVM configure'
if ! [ -e $HOME/.rvmrc ]; then echo 'rvm_install_on_use_flag=1' > $HOME/.rvmrc; fi
echo 'RVM load'
source $HOME/.rvm/scripts/rvm

# Install rubies
if [[ "$(rvm list)" =~ ^.*ruby-1.9.3.*$ ]]
then 
    echo 'ruby-1.9.3 already installed' 
else 
    echo 'rvm install 1.9.3'
    rvm install 1.9.3
fi

if [[ "$(rvm list)" =~ ^.*ruby-2.1.2.*$ ]] 
then 
    echo 'ruby-2.1.2 already installed'
else 
    echo 'rvm install 2.1.2'
    rvm install 2.1.2
fi

# Install Git
if ! git_loc="$(type -p git)" || [ -z "$git_loc" ]; then
    echo 'Git install'
    sudo apt-get install -y git
else
    echo 'Git already installed'
fi

echo 'Git configuration file'
if ! [ -e $HOME/.gitconfig ]; then ln -s /vagrant_synced_folder/vagrant.conf.d/.gitconfig $HOME/.; fi

echo 'Git set global user settings'
git config --global user.name "Daniel da Silva Ferreira (dsferreira)"
git config --global user.email "daniel.ferreira@dsferreira.com"

echo 'Bootstrap finished!'

