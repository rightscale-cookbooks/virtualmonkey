#
# Cookbook Name:: virtualmonkey
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

marker "recipe_start_rightscale" do
  template "rightscale_audit_entry.erb"
end

# Create the /etc/chef directory if it doesn't exist
directory "/etc/chef" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  mode 0755
  recursive true
  action :create
end

# Create the Knife PEM Key
file "/etc/chef/rightscalevirtualmonkey.pem" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  mode 0600
  content node[:virtualmonkey][:test_config][:knife_pem_key]
  action :create
end

# Creates the YAML file with credentials for "check_smtp" test for the
# "lamp_chef" feature.
directory "#{node[:virtualmonkey][:user_home]}/.virtualmonkey" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
end

template "#{node[:virtualmonkey][:user_home]}/.virtualmonkey/test_creds.yaml" do
  source "test_creds.yaml.erb"
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  variables(
    :smtp_username => node[:virtualmonkey][:test][:smtp_username],
    :smtp_password => node[:virtualmonkey][:test][:smtp_password]
  )
  mode 0600
end
