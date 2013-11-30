package('nodejs-legacy') do
  action :install
end

bash 'install_npm' do
  creates '/usr/bin/npm'
  code <<-EOH
    curl https://npmjs.org/install.sh | sh
  EOH
end
