%w(libxml2-dev libxslt-dev build-essential).each do |pkg|
  package(pkg) do
    action :install
  end
end

bash 'install_ruby' do
  creates '/usr/bin/ruby'
  code <<-EOH
    cd /tmp
    curl -O http://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.2.tar.gz
    tar xvzf ruby-2.1.2.tar.gz
    cd ruby-2.1.2
    ./configure
    make install
  EOH
end

cookbook_file('gemrc') do
  path '/etc/gemrc'
end

gem_package('bundler') do
  action :install
end
