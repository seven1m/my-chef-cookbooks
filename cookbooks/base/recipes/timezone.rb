bash('set_timezone') do
  only_if "date | grep UTC"
  code <<-EOH
    cp /usr/share/zoneinfo/#{node.timezone} /etc/localtime
  EOH
end
