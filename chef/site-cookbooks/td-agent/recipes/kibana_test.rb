#
# Cookbook Name:: td-agent
# Recipe:: default
#

include_recipe 'td-agent'

template "/etc/td-agent/td-agent.conf" do
  mode "0644"
  source node.td_agent.base_conf_template || "td-agent.conf.erb"
end
