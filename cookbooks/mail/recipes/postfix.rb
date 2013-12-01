package('postfix') do
  action :install
end

bash('set_mailname') do
  code <<-EOH
    hostname -f > /etc/mailname
  EOH
end

template('main.cf') do
  path '/etc/postfix/main.cf'
end

bash('stub_postfix_config_files') do
  creates '/etc/postfix/virtual_domains'
  code <<-EOH
    echo "domain1 domain2" > /etc/postfix/virtual_domains
    echo "you@domain1 user" > /etc/postfix/virtual
  EOH
end

iptables_rule "smtp"
