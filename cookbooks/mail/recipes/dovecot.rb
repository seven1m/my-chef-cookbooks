%w(dovecot-imapd dovecot-sieve dovecot-managesieved).each do |pkg|
  package(pkg) do
    action :install
  end
end

bash('config_dovecot') do
  code <<-EOH
    sed -i 's/^mail_location.*/mail_location = maildir:~\\/Maildir/' /etc/dovecot/conf.d/10-mail.conf
  EOH
end

service('dovecot') do
  action :restart
end
