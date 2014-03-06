#
# Cookbook Name:: virtualmonkey
# Recipe:: setup_virtualmonkey
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

packages = value_for_platform(
  "centos" => {
    "default" => ["libxml2-devel", "libxslt-devel", "file"]
  },
  "ubuntu" => {
    "default" => ["libxml2-dev", "libxml-ruby", "libxslt1-dev", "libmagic-dev"]
  }
)

# Installing packages required by VirtualMonkey
log "  Installing packages required by VirtualMonkey"
packages.each do |pkg|
  package pkg
end

# Check out right_api_object project from the Github repository
log "  Checking out right_api_objects project from:" +
        " #{node[:virtualmonkey][:virtualmonkey][:right_api_objects_repo_url]}"
git "#{node[:virtualmonkey][:user_home]}/right_api_objects" do
  repository node[:virtualmonkey][:virtualmonkey][:right_api_objects_repo_url]
  reference node[:virtualmonkey][:virtualmonkey][:right_api_objects_repo_branch]
  action :sync
end

# Check out the correct branch for right_api_objects
execute "git checkout" do
  cwd "#{node[:virtualmonkey][:user_home]}/right_api_objects"
  command "git checkout" +
              " #{node[:virtualmonkey][:virtualmonkey][:right_api_objects_repo_branch]}"
end

# Install the dependencies of right_api_objects
execute "bundle install" do
  cwd "#{node[:virtualmonkey][:user_home]}/right_api_objects"
  # We need this path set in order to support Ubuntu
  environment("PATH" => "#{ENV["PATH"]}:/usr/local/bin")
  command "bundle install"
end

# Install the right_api_objects gem
execute "rake install" do
  cwd "#{node[:virtualmonkey][:user_home]}/right_api_objects"
  command "rake install"
end

###############################################################################


# Installing right_cloud_api gem from the template file found in rightscale
# cookbook. The rightscale::install_tools installs this gem in sandbox ruby
# and we want it in system ruby
#
log "  Installing the right_cloud_api gem"

gem_file = "right_cloud_api-#{node[:virtualmonkey][:right_cloud_api_version]}.gem"
cookbook_file "/tmp/#{gem_file}" do
  cookbook "rightscale"
  source gem_file
end

gem_package "right_cloud_api" do
  gem_binary "/usr/bin/gem"
  source "/tmp/#{gem_file}"
  action :install
end

file "/tmp/#{gem_file}" do
  action :delete
end

log "  Obtaining collateral project name from repo URL"
basename_cmd = Mixlib::ShellOut.new("basename" +
  " #{node[:virtualmonkey][:virtualmonkey][:collateral_repo_url]} .git"
)
basename_cmd.run_command
basename_cmd.error!

node[:virtualmonkey][:virtualmonkey][:collateral_name] = basename_cmd.stdout.chomp

log "  Checking out collateral repo to" +
  " #{node[:virtualmonkey][:virtualmonkey][:collateral_name]}"
git "#{node[:virtualmonkey][:user_home]}/" +
  "#{node[:virtualmonkey][:virtualmonkey][:collateral_name]}" do
  repository node[:virtualmonkey][:virtualmonkey][:collateral_repo_url]
  reference node[:virtualmonkey][:virtualmonkey][:collateral_repo_branch]
  action :sync
end

execute "git checkout" do
  cwd "#{node[:virtualmonkey][:user_home]}/" +
    "#{node[:virtualmonkey][:virtualmonkey][:collateral_name]}"
  command "git checkout" +
    " #{node[:virtualmonkey][:virtualmonkey][:collateral_repo_branch]}"
end

log "  Installing gems required for the collateral project"
execute "bundle install on collateral" do
  cwd "#{node[:virtualmonkey][:user_home]}/" +
    "#{node[:virtualmonkey][:virtualmonkey][:collateral_name]}"
  # We need this path set in order to support Ubuntu
  environment("PATH" => "#{ENV["PATH"]}:/usr/local/bin")
  command "bundle install --no-color --system"
end

# The virtualmonkey main configuration file is created from a template initially
# allowing custom edits on the configuration.
directory "#{node['virtualmonkey']['user_home']}/.virtualmonkey" do
  owner node['virtualmonkey']['user']
  group node['virtualmonkey']['group']
end

template "#{node['virtualmonkey']['user_home']}/.virtualmonkey/config.yaml" do
  source "virtualmonkey_config.yaml.erb"
  owner node['virtualmonkey']['user']
  group node['virtualmonkey']['group']
  mode 0644
  variables(
    :east         => node['virtualmonkey']['aws_default_ssh_key_ids']['east'],
    :eu           => node['virtualmonkey']['aws_default_ssh_key_ids']['eu'],
    :us_west      => node['virtualmonkey']['aws_default_ssh_key_ids']['us_west'],
    :ap_singapore => node['virtualmonkey']['aws_default_ssh_key_ids']['ap_singapore'],
    :ap_tokyo     => node['virtualmonkey']['aws_default_ssh_key_ids']['ap_tokyo'],
    :us_oregon    => node['virtualmonkey']['aws_default_ssh_key_ids']['us_oregon'],
    :sa_sao_paolo => node['virtualmonkey']['aws_default_ssh_key_ids']['sa_sao_paolo'],
    :ap_sydney    => node['virtualmonkey']['aws_default_ssh_key_ids']['ap_sydney']
  )
  action :create_if_missing
end

# Populate all virtualmonkey cloud variables
log "  Populating virtualmonkey cloud variables"
execute "populate cloud variables" do
  cwd "#{node[:virtualmonkey][:user_home]}/" +
    "#{node[:virtualmonkey][:virtualmonkey][:collateral_name]}"
  # We need this path set in order to support Ubuntu
  environment("PATH" => "#{ENV["PATH"]}:/usr/local/bin")
  command "bundle exec monkey populate_all_cloud_vars" +
    " --force" +
    " --overwrite" +
    " --yes"
end

# Install the jsonlint tool for checking if the JSON file is valid
cookbook_file "/usr/bin/jsonlint" do
  source "jsonlint"
  mode 0755
end

# Create the directory for virtualmonkey log files
directory "/var/log/virtualmonkey" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  recursive true
end

# Create windows administrator password
file "#{node['virtualmonkey']['user_home']}/.virtualmonkey/windows_password" do
  content node['virtualmonkey']['virtualmonkey']['windows_admin_password']
  owner node['virtualmonkey']['user']
  group node['virtualmonkey']['group']
  mode 0600
end
