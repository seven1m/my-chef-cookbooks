# Tim's Chef Cookbooks

## Setup

```
vi /etc/hostname # set hostname
vi /etc/hosts    # set fqdn
aptitude update
aptitude install -y ruby ruby-dev build-essential
gem install --no-rdoc --no-ri chef ohai
ssh-keygen
cat ~/.ssh/id_rsa.pub # add key at https://github.com/settings/ssh
git clone git@github.com:seven1m/my-chef-cookbooks.git chef
cd chef
git submodule update --init
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
* web stack: apache, mysql, php, ruby, passenger, nodejs
