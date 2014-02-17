#
# Cookbook Name:: nginx
# recipe:: htpasswd
# Author:: me-me- <me-me-@fout.jp>
#

include_recipe 'htpasswd'

htpasswd "/etc/nginx/conf.d/kibana.htpasswd" do
  user "foo"
  password "bar"
end
