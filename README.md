# Tim's Chef Cookbooks

## Setup

```
vim /etc/hostname # set hostname
vim /etc/hosts    # set fqdn
aptitude update
aptitude install -y ruby ruby-dev build-essental
gem install --no-rdoc --no-ri chef ohai
```

## Cookbooks

```
chef-solo -c solo.rb
```

### Base

Installs a base system (Debian only at the moment) with:

* iptables
* shell tools: zsh, vim, git
* ssh
* apache
