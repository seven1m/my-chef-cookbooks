%w(vim ack-grep).each do |pkg|
  package(pkg) do
    action :install
  end
end

bash('configure_vim') do
  code <<-EOH
    [[ ! -x ~/.vim ]] && git clone git://github.com/seven1m/vimfiles.git ~/.vim
    cd ~/.vim
    git submodule update --init
    ln -s ~/.vim/vimrc ~/.vimrc
    mkdir -p ~/tmp
  EOH
end
