package('git') do
  action :install
end

bash "setup_git_user" do
  not_if "git config --global user.name"
  code <<-EOH
    git config --global user.name "#{node.git.user.name}"
    git config --global user.email "#{node.git.user.email}"
  EOH
end
