package('zsh') do
  action :install
end

bash('configure_zsh') do
  code <<-EOH
    [[ ! -e ~/.zsh ]] && git clone git://github.com/seven1m/oh-my-zsh.git ~/.zsh
    ln -s ~/.zsh/zshrc ~/.zshrc
    mkdir -p ~/.logs
    chsh -s /bin/zsh
  EOH
end
