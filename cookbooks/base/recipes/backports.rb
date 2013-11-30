bash 'enable_backports' do
  not_if 'grep "wheezy-backports" /etc/apt/sources.list'
  code <<-EOH
    echo 'deb http://ftp.us.debian.org/debian wheezy-backports main' >> /etc/apt/sources.list
    aptitude update
  EOH
end
