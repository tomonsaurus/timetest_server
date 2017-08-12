#!/usr/bin/env bash

echo "**set web2 server:"

echo "**exec user:"
whoami

################################################



# デフォルトエディタをvimに変更
sudo update-alternatives --set editor $(update-alternatives --list editor | grep 'vim.basic')


# パッケージリポジトリを日本ミラーサーバーに変更
sudo sed -i'~' -E "s@http://(..\.)?(archive|security)\.ubuntu\.com/ubuntu@http://ftp.jaist.ac.jp/pub/Linux/ubuntu@g" /etc/apt/sources.list

# よく使うパッケージをインストール
sudo apt-get -y update
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get -y update
sudo apt-get -y install language-pack-ja wget curl zip unzip git

# 言語系環境変数を日本語UTF-8に変更
sudo update-locale LANGUAGE=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8 LANG=ja_JP.UTF-8

# タイムゾーンをAsia/Tokyoに設定
sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

sudo apt-get install -y apache2
sudo apt-get install -y php5 libapache2-mod-php5

sudo service apache2 start



# テスト用HTTP PHPコンテンツのコピー
sudo cp -R /home/vagrant/src/html/* /var/www







echo "**end: web"

