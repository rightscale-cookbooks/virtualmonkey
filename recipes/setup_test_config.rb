#
# Cookbook Name:: rightscale_monkey
# Recipe:: setup_test_config
#
# Copyright (C) 2013 RightScale, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

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
