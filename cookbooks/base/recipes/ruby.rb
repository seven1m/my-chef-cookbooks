cookbook_file('gemrc') do
  path '/etc/gemrc'
end

gem_package('bundler') do
  action :install
end
