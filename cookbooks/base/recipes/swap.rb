bash('create_swap') do
  creates '/swap'
  code <<-EOH
    dd if=/dev/zero of=/swap bs=1M count=1024
    mkswap /swap
    swapon /swap
    echo "/swap none swap sw 0 0" >> /etc/fstab
  EOH
end
