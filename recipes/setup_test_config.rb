#
# Cookbook Name:: monkey
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

# Create the /etc/chef directory if it doesn't exist
directory "/etc/chef" do
  owner node[:rightscale_monkey][:user]
  group node[:rightscale_monkey][:group]
  mode 0755
  recursive true
  action :create
end

# Create the Knife PEM Key
file "/etc/chef/rightscalevirtualmonkey.pem" do
  owner node[:rightscale_monkey][:user]
  group node[:rightscale_monkey][:group]
  mode 0600
  content node[:rightscale_monkey][:test_config][:knife_pem_key]
  action :create
end

# Creates the YAML file with credentials for "check_smtp" test for the
# "lamp_chef" feature.
directory "#{node[:rightscale_monkey][:user_home]}/.virtualmonkey" do
  owner node[:rightscale_monkey][:user]
  group node[:rightscale_monkey][:group]
end

template "#{node[:rightscale_monkey][:user_home]}/.virtualmonkey/test_creds.yaml" do
  source "test_creds.yaml.erb"
  owner node[:rightscale_monkey][:user]
  group node[:rightscale_monkey][:group]
  variables(
    :smtp_username => node[:rightscale_monkey][:test][:smtp_username],
    :smtp_password => node[:rightscale_monkey][:test][:smtp_password]
  )
  mode 0600
end
