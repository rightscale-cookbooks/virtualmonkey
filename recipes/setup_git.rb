#
# Cookbook Name:: monkey
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

rightscale_marker

log "  Creating ssh directory for root user"
directory "#{node[:rightscale_monkey][:user_home]}/.ssh" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

log "  Adding git private key for root user"
file "#{node[:rightscale_monkey][:user_home]}/.ssh/git_id_rsa" do
  owner node[:rightscale_monkey][:user]
  group node[:rightscale_monkey][:group]
  mode "0600"
  content node[:rightscale_monkey][:git][:ssh_key]
  action :create
end

# Configuring ssh to add github
log "  Configuring ssh to add github"
template "#{node[:rightscale_monkey][:user_home]}/.ssh/config" do
  source "sshconfig.erb"
  variables(
    :git_hostname => node[:rightscale_monkey][:git][:host_name],
    :keyfile => "#{node[:rightscale_monkey][:user_home]}/.ssh/git_id_rsa"
  )
  cookbook "monkey"
end

# Setting up git configuration for root user
log "  Setting up git configuration for root user"
template "#{node[:rightscale_monkey][:user_home]}/.gitconfig" do
  source "gitconfig.erb"
  variables(
    :git_user => node[:rightscale_monkey][:git][:user],
    :git_email => node[:rightscale_monkey][:git][:email]
  )
  cookbook "monkey"
end
