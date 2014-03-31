bash "composer update" do
  code <<-EOS
    cd #{node[:app_root]}; composer update
  EOS
end

