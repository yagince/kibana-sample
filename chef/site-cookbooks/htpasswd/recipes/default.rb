#
# Cookbook Name:: htpasswd
# recipe:: default
# Author:: me-me- <me-me-@fout.jp>
#

htpasswd "/etc/nginx/conf.d/kibana.htpasswd" do
  user "admin"
  password "admin"
end
