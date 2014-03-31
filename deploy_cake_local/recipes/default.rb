# tmpディレクトリ作成
directory "#{node[:app_root]}app/tmp" do
  owner 'vagrant'
  group 'vagrant'
  mode 0777
  action :create
  not_if {::File.exists?("#{node[:app_root]}app/tmp")}
end

bash "run cake console command" do
  code <<-EOS
    cd #{node[:app_root]}; composer update
    cd #{node[:app_root]}app; yes | ./Console/cake schema update
  EOS
end
