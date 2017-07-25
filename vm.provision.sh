#!/usr/bin/env bash
#Обновление менеджера пакетов
sudo apt-get update --fix-missing

# Устанавливаем mc:
sudo apt-get -y install mc

# Обновление composer
sudo composer self-update

# Обновление nodejs/npm до последней версии:
sudo npm cache clean -f
sudo npm install -g n
sudo n stable

#Копируем дефолтный хост
cp -r /vagrant/public/* /var/www

# Добавляем виртуальные хосты из папки «www»:
for vhFile in /var/www/vhosts/*.conf
do
    # копируем конфигурационные файлы хостов в специально предназначенную для этого папку apache
    sudo cp /var/www/vhosts/*.conf /etc/apache2/sites-available/ -R
    vhConf=${vhFile##*/}
    # регистрируем хосты
    sudo a2ensite ${vhConf}
    vhost=${vhConf%.*}
    # Добавляем запись в /etc/hosts
    sudo sed -i "2i${vmip}    ${vhost}" /etc/hosts
done

# Установка xdebug
cd ~ && mkdir src && cd src
wget http://xdebug.org/files/xdebug-2.5.4.tgz
tar -xvzf xdebug-2.5.4.tgz
cd xdebug-2.5.4
sudo apt-get install -y php7.0-dev
phpize
./configure
make
sudo cp modules/xdebug.so /usr/lib/php/20151012
cat /vagrant/config/xdebug.ini | sudo tee -a /etc/php/7.0/apache2/php.ini

# выставляем права и перезапускаем apache
#sudo chmod -R 755 /var/www
sudo service apache2 restart

# Установка zsh
sudo apt-get -y install zsh
sudo usermod -s /usr/bin/zsh vagrant
#cp /vagrant/config/.zshrc ~/zshrc
echo 'Now run'
echo 'sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"'
echo 'to install oh-my-zsh plugin'
