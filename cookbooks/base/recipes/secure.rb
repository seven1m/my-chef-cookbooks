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

package('iptables') do
  action :install
end

bash "setup_iptables" do
  not_if "ls /etc/iptables.rules"
  code <<-EOH
    iptables -F
    iptables -A INPUT -p icmp -j ACCEPT
    iptables -A INPUT -s 127.0.0.1 -j ACCEPT
    iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A FORWARD -i eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
    iptables -A OUTPUT -m state --state NEW,RELATED,ESTABLISHED -j ACCEPT
    iptables -A INPUT -p tcp -m state --state NEW --dport 22 -j ACCEPT
    iptables -A INPUT -j REJECT
    iptables -A FORWARD -j REJECT
    iptables-save > /etc/iptables.rules
    sed -i '/iface eth0/a pre-up iptables-restore < /etc/iptables.rules' /etc/network/interfaces
  EOH
end
