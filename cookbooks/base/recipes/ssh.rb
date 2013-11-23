keys = File.read("#{ENV['HOME']}/.ssh/authorized_keys") rescue ''
unless keys =~ /ssh-rsa/
  user = ENV['USER']
  ip = `ip addr show eth0 | grep "inet "`.split[1].sub(/\/.+/, '')
  puts "\033[32mWARNING\033[0m: you did not copy your SSH key, so I did not disable password login."
  puts "On your local terminal: \033[34mssh-copy-id #{user}@#{ip}\033[0m"
  return
end

bash "disable_ssh_password_login" do
  only_if "grep 'PasswordAuthentication yes' /etc/ssh/sshd_config"
  code <<-EOH
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    /etc/init.d/ssh restart
  EOH
end

iptables_rule "ssh"
