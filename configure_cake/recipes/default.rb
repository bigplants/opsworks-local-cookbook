# tmpディレクトリ作成
directory "#{node[:app_root]}app/tmp" do
  owner 'deploy'
  group 'www-data'
  mode 0777
  action :create
  not_if {::File.exists?("#{node[:app_root]}app/tmp")}
end

# Cakeのコンソール(dbの情報が取得できた場合のみ)
bash "cake db migration" do
  code <<-EOS
    cd #{node[:app_root]}app; yes | ./Console/cake migrations.migration run all
  EOS
  not_if {deploy[:database][:host] == ''}
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
