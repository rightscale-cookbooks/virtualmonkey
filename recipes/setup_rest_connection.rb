#
# Cookbook Name:: virtualmonkey
# Recipe:: setup_rest_connection
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

# Installing packages needed for rest_connection
packages = value_for_platform(
  "centos" => {
    "default" => ["libxml2-devel",  "libxslt-devel"]
  },
  "ubuntu" => {
    "default" => ["libxml2-dev", "libxslt1-dev"]
  }
)

log "  Installing packages required by rest_connection"
packages.each do |pkg|
  package pkg
end unless packages.empty?


if node['virtualmonkey']['ruby']['version'] == "1.8"
  # Install rubygems compatible with Ruby 1.8.7. By default rubygems 2.x.x gets
  # installed.
  gem_package "rubygems-update" do
    gem_binary "/usr/bin/gem"
    version node[:virtualmonkey][:rubygems_update_version]
    action :install
  end

  # Set the update rubygems command based on the platform
  execute "update rubygems" do
    command value_for_platform(
      "ubuntu" => {
        "default" => "/usr/local/bin/update_rubygems"
      },
      "default" => "/usr/bin/update_rubygems"
    )
  end
end

# If were running on ruby 1.9 override the rest_connection and other basic gem versions
if node['virtualmonkey']['ruby']['version'] == "1.9"
  node['virtualmonkey']['rest']['gem_packages'] = {
      "rake" => "10.1.0",
      "bundler" => "1.3.5",
      "ruby-debug19" => "0.11.6",
      "gemedit" => "1.0.1",
      "diff-lcs" => "1.2.5",
      "rspec" => "2.14.1",
      "json" => "1.7.7"
  }
  # Since ruby-debug was renamed to ruby-debug19 we have to delete the old entry
  node['virtualmonkey']['rest']['gem_packages'].delete "ruby-debug"
end

# Installing gem dependencies
log "  Installing gems requierd by rest_connection"
node[:virtualmonkey][:rest][:gem_packages].each do |gem_name, gem_version|
  gem_package gem_name do
    gem_binary "/usr/bin/gem"
    version gem_version
    action :install
  end
end

log "  Creating rest_connection configuration directory"
directory "#{node[:virtualmonkey][:user_home]}/.rest_connection" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  mode "0755"
  action :create
end

# Create the private key used for SSH
file "#{node[:virtualmonkey][:user_home]}/.ssh/api_user_key" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  mode 0600
  content node[:virtualmonkey][:rest][:ssh_key]
  action :create
end

template "#{node[:virtualmonkey][:user_home]}/.rest_connection/rest_api_config.yaml" do
  source "rest_api_config.yaml.erb"
  variables(
    :right_passwd => node[:virtualmonkey][:rest][:right_passwd],
    :right_email => node[:virtualmonkey][:rest][:right_email],
    :right_acct_id => node[:virtualmonkey][:rest][:right_acct_id],
    :right_subdomain => node[:virtualmonkey][:rest][:right_subdomain],
    :azure_hack_on => node[:virtualmonkey][:rest][:azure_hack_on],
    :azure_hack_retry_count => node[:virtualmonkey][:rest][:azure_hack_retry_count],
    :azure_hack_sleep_seconds =>
      node[:virtualmonkey][:rest][:azure_hack_sleep_seconds],
    :api_logging => node[:virtualmonkey][:rest][:api_logging],
    :legacy_shard => node[:virtualmonkey][:rest][:legacy_shard],
    :ssh_keys => ["#{node[:virtualmonkey][:user_home]}/.ssh/api_user_key"]
  )
end

# Create the authorized_keys file if it doesn't exist
file "#{node[:virtualmonkey][:user_home]}/.ssh/authorized_keys" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  mode 0644
  action :create
end

unless node[:virtualmonkey][:rest][:ssh_pub_key].empty?
  execute "add public key to authorized keys" do
    command "echo #{node[:virtualmonkey][:rest][:ssh_pub_key]} >>" +
      " #{node[:virtualmonkey][:user_home]}/.ssh/authorized_keys"
    not_if do
      File.open("#{ENV['HOME']}/.ssh/authorized_keys").lines.any? do |line|
        line.chomp == node[:'rs-jenkins'][:public_key]
      end
    end
  end
end
