#!/usr/bin/env bash


echo "**exec user:"
whoami

################################################
echo "**yum install"

sudo yum -y install perl vim gcc  git


sudo yum install -y -q ntp

sudo timedatectl set-timezone Asia/Tokyo
sudo yum install -y openssl-devel readline-devel zlib-devel

# centos7
sudo sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd
sudo sed -i -e 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config



sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network

sudo yum install -y wget



################################################
sudo yum install -y ruby

# テスト用のためrubyは早くインストールできるようにcentos7付属のものにしておく

<< COMMENTOUT

echo "**rbenv"
cd ~
if [[ ! -d $HOME/.rbenv ]]; then
  git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
  echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
  cat ~/.bash_profile
  source ~/.bash_profile
  git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

RUBY_INSTALL_VERSION='2.3.4'

echo "**ruby"
VERSION=`rbenv versions`
echo $VERSION
echo $RUBY_INSTALL_VERSION
if [[ ! $VERSION =~ $RUBY_INSTALL_VERSION ]]; then
  echo 'Now, we start to install ruby. you must wait for about 15 minuites.!! long long time.'
    rbenv install $RUBY_INSTALL_VERSION
  rbenv global $RUBY_INSTALL_VERSION
  ruby -v    
    
fi

echo 'gem: --no-ri --no-rdoc' > ~/.gemrc
rbenv exec gem install bundler

rbenv rehash

COMMENTOUT



# rspec, serverspecのインストール
gem install bundler

bundle init


#echo 'gem "rspec"' >> Gemfile
#echo 'gem "serverspec"' >> Gemfile
echo 'gem "thor"' >> Gemfile
#echo 'gem "infrataster"' >> Gemfile




bundle install --path ~/vendor/bundle 

bundle install --binstubs

# ansibleインストール

sudo yum install -y epel-release
sudo yum install -y ansible sshpass



# 時間設定


# atコマンド
sudo yum install -y at

sudo systemctl enable atd
sudo systemctl start atd

# phantoms for infrataster capybara
#sudo rpm -ivh http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm
#sudo yum -y install phantomjs

echo "**end: admin server"

