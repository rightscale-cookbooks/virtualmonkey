#
# Cookbook Name:: virtualmonkey
# Recipe:: setup_git
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

log "  Creating ssh directory for root user"
directory "#{node[:virtualmonkey][:user_home]}/.ssh" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

log "  Adding git private key for root user"
file "#{node[:virtualmonkey][:user_home]}/.ssh/git_id_rsa" do
  owner node[:virtualmonkey][:user]
  group node[:virtualmonkey][:group]
  mode "0600"
  content node[:virtualmonkey][:git][:ssh_key]
  action :create
end

# Configuring ssh to add github
log "  Configuring ssh to add github"
template "#{node[:virtualmonkey][:user_home]}/.ssh/config" do
  source "sshconfig.erb"
  variables(
    :git_hostname => node[:virtualmonkey][:git][:host_name],
    :keyfile => "#{node[:virtualmonkey][:user_home]}/.ssh/git_id_rsa"
  )
end

# Setting up git configuration for root user
log "  Setting up git configuration for root user"
template "#{node[:virtualmonkey][:user_home]}/.gitconfig" do
  source "gitconfig.erb"
  variables(
    :git_user => node[:virtualmonkey][:git][:user],
    :git_email => node[:virtualmonkey][:git][:email]
  )
end
