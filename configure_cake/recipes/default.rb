bash "composer update" do
  code <<-EOS
    cd #{node[:app_root]}; composer update
  EOS
end


# tmpディレクトリ作成
directory "#{node[:app_root]}app/tmp" do
  owner 'deploy'
  group 'www-data'
  mode 0777
  action :create
  not_if {::File.exists?("#{node[:app_root]}app/tmp")}
end

# Cakeのコンソール
bash "cake db migration" do
  code <<-EOS
    cd #{node[:app_root]}app; yes | ./Console/cake migrations.migration run all
  EOS
end

# tmpディレクトリを一旦削除
directory "#{node[:app_root]}app/tmp" do
  recursive true
  action :delete
end

# tmpディレクトリ作成
directory "#{node[:app_root]}app/tmp" do
  owner 'deploy'
  group 'www-data'
  mode 0777
  action :create
  not_if {::File.exists?("#{node[:app_root]}app/tmp")}
end
