package('nodejs-legacy') do
  action :install
end

bash 'install_npm' do
  creates '/usr/bin/npm'
  code <<-EOH
    curl https://www.npmjs.org/install.sh | clean=yes sh
  EOH
end
