%w(spamassassin spamc).each do |pkg|
  package(pkg) do
    action :install
  end
end

bash('enable_spamassassin') do
  not_if "grep spamassassin /etc/postfix/master.cf"
  code <<-EOH
    sed -i 's/^ENABLED.*/ENABLED=1/' /etc/default/spamassassin
    mkdir -p /var/lib/spamassassin
    chown -R debian-spamd:debian-spamd /var/lib/spamassassin
    echo -e "spamassassin unix -     n       n       -       -       pipe\n  user=debian-spamd argv=/usr/bin/spamc -f -e\n  /usr/sbin/sendmail -oi -f ${sender} ${recipient}" >> /etc/postfix/master.cf
    sed -i -e 's/^#smtps.*smtpd$/smtps     inet  n       -       -       -       -       smtpd/' -e '/^smtp.*smtpd$/a\\  -o content_filter=spamassassin' /etc/postfix/master.cf
  EOH
end

template('sieve_config') do
  path '/etc/dovecot/conf.d/99-enablesieve.conf'
  action :create_if_missing
end

service('spamassassin') do
  action :restart
end

service('postfix') do
  action :restart
end
