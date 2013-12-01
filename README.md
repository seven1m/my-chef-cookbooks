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

### Base

```
chef-solo -c solo.rb
```

Installs a base system (Debian only at the moment) with:

* iptables
* shell tools: zsh, vim, git
* ssh
* web stack: apache, mysql, php, ruby, passenger, nodejs

### Mail

```
chef-solo -c solo.rb -o mail
```

Install Postfix, Dovecot, Spamassassin, and more.

After running, be sure to:

```
vim /etc/postfix/virtual_domains
vim /etc/postfix/virtual
postmap /etc/postfix/virtual
postfix reload
```
