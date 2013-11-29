%w(ruby ruby-dev libxml2-dev libxslt-dev libreadline-ruby libruby libopenssl-ruby build-essential libmysql-ruby).each do |pkg|
  package(pkg) do
    action :install
  end
end

cookbook_file('gemrc') do
  path '/etc/gemrc'
end

gem_package('bundler') do
  action :install
end
