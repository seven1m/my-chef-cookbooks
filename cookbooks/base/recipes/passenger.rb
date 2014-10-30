bash('install_passenger') do
  creates '/etc/apt/sources.list.d/passenger.list'
  code <<-EOH
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7 
    apt-get install -y apt-transport-https ca-certificates
    echo "deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main" > /etc/apt/sources.list.d/passenger.list
    chmod 600 /etc/apt/sources.list.d/passenger.list
  EOH
end

package('libapache2-mod-passenger') do
  action :install
end

bash('enable_module') do
  code <<-EOH
    a2enmod passenger
  EOH
end

service('apache2') do
  action :restart
end
