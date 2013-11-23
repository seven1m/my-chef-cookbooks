package('apache2') do
  action :install
end

service('apache2') do
  action :start
  action :enable
end

iptables_rule "http"
