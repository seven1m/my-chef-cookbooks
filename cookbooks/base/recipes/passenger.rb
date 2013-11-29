gem_package('passenger') do
  action :install
end

%w(libaprutil1-dev libapr1-dev apache2-threaded-dev libssl-dev libcurl4-openssl-dev).each do |pkg|
  package(pkg) do
    action :install
  end
end

bash('install_passenger') do
  creates '/etc/apache2/conf.d/passenger'
  code <<-EOH
    passenger-install-apache2-module --auto
    passenger-install-apache2-module --snippet > /etc/apache2/conf.d/passenger
    service apache2 restart
  EOH
end
