#
# Cookbook Name:: monkey
#
# Copyright RightScale, Inc. All rights reserved.
# All access and use subject to the RightScale Terms of Service available at
# http://www.rightscale.com/terms.php and, if applicable, other agreements
# such as a RightScale Master Subscription Agreement.

# Required attributes
#

# Fog Credentials

# AWS Access Key ID
default[:rightscale_monkey][:fog][:aws_access_key_id] = ""
# AWS Secret Access Key
default[:rightscale_monkey][:fog][:aws_secret_access_key] = ""
# AWS Publish Access Key ID
default[:rightscale_monkey][:fog][:aws_publish_key] = ""
# AWS Publish Secret Key
default[:rightscale_monkey][:fog][:aws_publish_secret_key] = ""
# AWS Access Key ID for Test Account
default[:rightscale_monkey][:fog][:aws_access_key_id_test] = ""
# AWS Secret Access Key for Test Account
default[:rightscale_monkey][:fog][:aws_secret_access_key_test] = ""
# Rackspace API Key
default[:rightscale_monkey][:fog][:rackspace_api_key] = ""
# Rackspace Username
default[:rightscale_monkey][:fog][:rackspace_username] = ""
# Rackspace UK API Key for Test Account
default[:rightscale_monkey][:fog][:rackspace_api_uk_key_test] = ""
# Rackspace UK Username for Test Account
default[:rightscale_monkey][:fog][:rackspace_uk_username_test] = ""
# AWS Access Key ID for RS ServerTemplates Account
default[:rightscale_monkey][:fog][:aws_access_key_id_rstemp] = ""
# AWS Secret Access Key for RS ServerTemplates Account
default[:rightscale_monkey][:fog][:aws_secret_access_key_rstemp] = ""
# Softlayer API Key
default[:rightscale_monkey][:fog][:softlayer_api_key] = ""
# Softlayer Username
default[:rightscale_monkey][:fog][:softlayer_username] = ""
# Rackspace Managed Auth Key
default[:rightscale_monkey][:fog][:rackspace_managed_auth_key] = ""
# Rackspace Managed Username
default[:rightscale_monkey][:fog][:rackspace_managed_username] = ""
# Rackspace Managed UK Auth Key for Test Account
default[:rightscale_monkey][:fog][:rackspace_managed_uk_auth_key] = ""
# Rackspace Managed UK Username for Test Accounr
default[:rightscale_monkey][:fog][:rackspace_managed_uk_username] = ""
# Rackspace UK Auth URL for Test Account
default[:rightscale_monkey][:fog][:rackspace_auth_url_uk_test] = ""
# Google Access Key ID
default[:rightscale_monkey][:fog][:google_access_key_id] = ""
# Google Secret Access Key
default[:rightscale_monkey][:fog][:google_secret_access_key] = ""
# Azure Access Key ID
default[:rightscale_monkey][:fog][:azure_access_key_id] = ""
# Azure Secret Access Key
default[:rightscale_monkey][:fog][:azure_secret_access_key] = ""
# S3 Bucket Name for Reports Storage
default[:rightscale_monkey][:fog][:s3_bucket] = ""
# Openstack Folsom Access Key ID
default[:rightscale_monkey][:fog][:openstack_access_key_id] = ""
# Openstack Folsom Secret Access Key
default[:rightscale_monkey][:fog][:openstack_secret_access_key] = ""
# Openstack Auth URL
default[:rightscale_monkey][:fog][:openstack_auth_url] = ""
# Rackspace Private Access Key ID
default[:rightscale_monkey][:fog][:raxprivatev3_access_key_id] = ""
# Rackspace Private Secret Access Key
default[:rightscale_monkey][:fog][:raxprivatev3_secret_access_key] = ""
# Rackspace Private Auth URL
default[:rightscale_monkey][:fog][:raxprivatev3_auth_url] = ""
# HP Access Key ID
default[:rightscale_monkey][:fog][:hp_access_key_id] = ""
# HP Secret Access Key
default[:rightscale_monkey][:fog][:hp_secret_access_key] = ""
# HP Auth URL
default[:rightscale_monkey][:fog][:hp_auth_url] = ""

# Git Settings

# Git Username
default[:rightscale_monkey][:git][:user] = ""
# Git Email
default[:rightscale_monkey][:git][:email] = ""
# Git SSH Key
default[:rightscale_monkey][:git][:ssh_key] = ""
# Git Hostname
default[:rightscale_monkey][:git][:host_name] = ""

# Rest Connection Settings

# RightScale Password
default[:rightscale_monkey][:rest][:right_passwd] = ""
# RightScale Email
default[:rightscale_monkey][:rest][:right_email] = ""
# RightScale Account ID
default[:rightscale_monkey][:rest][:right_acct_id] = ""
# RightScale Subdomain
default[:rightscale_monkey][:rest][:right_subdomain] = ""
# SSH Key Used by Rest Connection
default[:rightscale_monkey][:rest][:ssh_key] = ""
# Public Key for allowing connections from
default[:rightscale_monkey][:rest][:ssh_pub_key] = ""
# Rest Connection Repository URL
default[:rightscale_monkey][:rest][:repo_url] = ""
# Rest Connection Repository Branch
default[:rightscale_monkey][:rest][:repo_branch] = ""

# Test Specific Configuration Settings

# Knife PEM Key used by Chef Client Tests
default[:rightscale_monkey][:test_config][:knife_pem_key] = ""

# VirtualMonkey Settings

# VirtualMonkey Repository URL
default[:rightscale_monkey][:virtualmonkey][:rightscale_monkey_repo_url] = ""
# VirtualMonkey Repository Branch
default[:rightscale_monkey][:virtualmonkey][:rightscale_monkey_repo_branch] = ""
# Collateral Repository URL
default[:rightscale_monkey][:virtualmonkey][:collateral_repo_url] = ""
# Collateral Repository Branch
default[:rightscale_monkey][:virtualmonkey][:collateral_repo_branch] = ""
# Right API Objects Repository URL
default[:rightscale_monkey][:virtualmonkey][:right_api_objects_repo_url] = ""
# Right API Objects Repository Branch
default[:rightscale_monkey][:virtualmonkey][:right_api_objects_repo_branch] = ""

# RocketMonkey Settings

# RocketMonkey Repository URL
default[:rightscale_monkey][:rocketmonkey][:repo_url] = ""
# RocketMonkey Repository Branch
default[:rightscale_monkey][:rocketmonkey][:repo_branch] = ""

# Recommended attributes
#

# Gems required for rest_connection
default[:rightscale_monkey][:rest][:gem_packages] = {
  "rake" => "10.0.3",
  "bundler" => "1.2.3",
  "jeweler" => "1.8.4",
  "ruby-debug" => "0.10.4",
  "gemedit" => "1.0.1",
  "diff-lcs" => "1.1.3",
  "rspec" => "2.12.0",
  "json" => "1.7.7"
}
# Monkey user
default[:rightscale_monkey][:user] = "root"
# Monkey user's home directory
default[:rightscale_monkey][:user_home] = "/root"
# Monkey group
default[:rightscale_monkey][:group] = "root"
# Rest connection path
default[:rightscale_monkey][:rest_connection_path] =
  "#{node[:rightscale_monkey][:user_home]}/rest_connection"
# Virtualmonkey path
default[:rightscale_monkey][:virtualmonkey_path] =
  "#{node[:rightscale_monkey][:user_home]}/virtualmonkey"
# Rocketmonkey path
default[:rightscale_monkey][:rocketmonkey_path] =
  "#{node[:rightscale_monkey][:user_home]}/rocketmonkey"
# The version for the rubygems-update gem
default[:rightscale_monkey][:rubygems_update_version] = "1.8.24"
# The version of right_cloud_api rubygem to install
default[:rightscale_monkey][:right_cloud_api_version] = "0.0.1"

# Optional Attributes

# Azure Hack on/off
default[:rightscale_monkey][:rest][:azure_hack_on] = ""
# Azure Hack Retry Count
default[:rightscale_monkey][:rest][:azure_hack_retry_count] = ""
# Azure Hack Sleep Seconds
default[:rightscale_monkey][:rest][:azure_hack_sleep_seconds] = ""
# API Logging on/off
default[:rightscale_monkey][:rest][:api_logging] = ""

# Calculated Attributes

# Azure Endpoint is calculated from the Access Key ID
default[:rightscale_monkey][:fog][:azure_endpoint] = "https://" +
  "#{node[:rightscale_monkey][:fog][:azure_access_key_id]}.blob.core.windows.net"
