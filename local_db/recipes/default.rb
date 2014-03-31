packages = %w{mysql-server}

packages.each do |pkg|
  package pkg do
    action [:install, :upgrade]
    version node[:versions][pkg]
  end
end

template "/etc/mysql/my.cnf" do
  mode 0644
  source "my.cnf.erb"
end

%w{mysql}.each do |service_name|
    service service_name do
      action [:start, :restart]
    end
end
bash "create local db" do
  code <<-EOS
    mysql -u root --execute  "create database if not exists myapp"
    mysql -u root --execute  "create database if not exists myapp_test"
  EOS
end