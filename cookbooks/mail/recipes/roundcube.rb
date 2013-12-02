remote_file('/tmp/roundcube.tgz') do
  source 'http://downloads.sourceforge.net/project/roundcubemail/roundcubemail-beta/1.0-beta/roundcubemail-1.0-beta.tar.gz?r=http%3A%2F%2Froundcube.net%2Fdownload%2F&ts=1385874116&use_mirror=softlayer-ams'
  action :create_if_missing
end

bash('install_roundcube') do
  creates "/var/www/apps/roundcube"
  code <<-EOH
    set -e
    cd /tmp
    tar xzf roundcube.tgz
    mkdir -p /var/www/apps
    mv roundcubemail-* /var/www/apps/roundcube
    cd /var/www/apps/roundcube
    mysql -uroot -e "CREATE DATABASE roundcubemail CHARACTER SET utf8 COLLATE utf8_general_ci; GRANT ALL PRIVILEGES ON roundcubemail.* TO roundcube@localhost IDENTIFIED BY 'roundcube';"
    mysql -uroot roundcubemail < SQL/mysql.initial.sql
    chown -R www-data:www-data .
    chmod -R 777 logs temp
  EOH
end

template('roundcube_config') do
  path '/var/www/apps/roundcube/config/config.inc.php'
  action :create_if_missing
end
