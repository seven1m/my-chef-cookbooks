include_recipe 'iptables'

iptables_rule "loopback"
iptables_rule "all_out"
