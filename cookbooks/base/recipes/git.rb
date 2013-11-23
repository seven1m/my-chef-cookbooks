package('git') do
  action :install
end

bash "setup_git_user" do
  not_if "git config --global user.name"
  code <<-EOH
    git config --global user.name "Tim Morgan"
    git config --global user.email "tim@timmorgan.org"
  EOH
end
