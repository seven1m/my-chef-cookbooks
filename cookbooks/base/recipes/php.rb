%w(libapache2-mod-php5 php5-mysql).each do |pkg|
  package(pkg) do
    action :install
  end
end
