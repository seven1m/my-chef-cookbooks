package('emacs') do
  action :install
end

bash('configure_emacs') do
  code <<-EOH
    [[ ! -e ~/.emacs.d ]] && git clone git://github.com/seven1m/.emacs.d.git ~/.emacs.d
    cd ~/.emacs.d
    git submodule update --init
  EOH
end
