#!/usr/bin/env bash

echo "**set web server:"

echo "**exec user:"
whoami

################################################
echo "**yum install"

sudo yum -y install perl vim gcc  git wget sshpass


sudo yum install -y -q ntp

sudo service ntpd stop
sudo chkconfig nptd off

# 日本時間設定
sudo cp /usr/share/zoneinfo/Japan /etc/localtime
sudo sed -i -e "s|ZONE=\"UTC\"|ZONE=\"Asia/Tokyo\"|g" /etc/sysconfig/clock

sudo yum install -y openssl-devel readline-devel zlib-devel

sudo sed -i -e 's/^PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo service sshd restart

#sudo sed -i -e 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config


sudo yum install -y httpd php php-mbstring php-pear

# php.ini 
sudo sed -i -e "s|;date.timezone =|date.timezone = Asia/Tokyo|" /etc/php.ini

sudo service iptables stop
sudo service httpd start

sudo chkconfig httpd on
sudo chkconfig iptables off

#yum install -y mysql-server.x86_64
#service mysqld start
#chkconfig mysqld on

#yum install -y php-mysql.x86_64


# srcのコピー



# テスト用HTTP PHPコンテンツのコピー
sudo cp -R /home/vagrant/src/html /var/www

# vagrantユーザーにcronを登録
crontab /home/vagrant/src/cron.txt



# 時間設定


# atコマンド
sudo yum install -y at

sudo chkconfig atd on
sudo service atd start



# atコマンドを追加　2017/8/1 11:00に実行　ログに出力するだけのプログラム
at "11:00 01.08.17"  -f ~/src/batch/atexec.sh


# web app

echo "**end: web"

