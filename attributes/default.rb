#
# Cookbook Name:: virtualmonkey
# Attribute:: default
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

# Required attributes
#

# Fog Credentials

# AWS Access Key ID
default[:virtualmonkey][:fog][:aws_access_key_id] = ""
# AWS Secret Access Key
default[:virtualmonkey][:fog][:aws_secret_access_key] = ""
# AWS Publish Access Key ID
default[:virtualmonkey][:fog][:aws_publish_key] = ""
# AWS Publish Secret Key
default[:virtualmonkey][:fog][:aws_publish_secret_key] = ""
# AWS Access Key ID for Test Account
default[:virtualmonkey][:fog][:aws_access_key_id_test] = ""
# AWS Secret Access Key for Test Account
default[:virtualmonkey][:fog][:aws_secret_access_key_test] = ""
# Rackspace API Key
default[:virtualmonkey][:fog][:rackspace_api_key] = ""
# Rackspace Username
default[:virtualmonkey][:fog][:rackspace_username] = ""
# Rackspace UK API Key for Test Account
default[:virtualmonkey][:fog][:rackspace_api_uk_key_test] = ""
# Rackspace UK Username for Test Account
default[:virtualmonkey][:fog][:rackspace_uk_username_test] = ""
# AWS Access Key ID for RS ServerTemplates Account
default[:virtualmonkey][:fog][:aws_access_key_id_rstemp] = ""
# AWS Secret Access Key for RS ServerTemplates Account
default[:virtualmonkey][:fog][:aws_secret_access_key_rstemp] = ""
# Softlayer API Key
default[:virtualmonkey][:fog][:softlayer_api_key] = ""
# Softlayer Username
default[:virtualmonkey][:fog][:softlayer_username] = ""
# Rackspace Managed Auth Key
default[:virtualmonkey][:fog][:rackspace_managed_auth_key] = ""
# Rackspace Managed Username
default[:virtualmonkey][:fog][:rackspace_managed_username] = ""
# Rackspace Managed UK Auth Key for Test Account
default[:virtualmonkey][:fog][:rackspace_managed_uk_auth_key] = ""
# Rackspace Managed UK Username for Test Accounr
default[:virtualmonkey][:fog][:rackspace_managed_uk_username] = ""
# Rackspace UK Auth URL for Test Account
default[:virtualmonkey][:fog][:rackspace_auth_url_uk_test] = ""
# Google Access Key ID
default[:virtualmonkey][:fog][:google_access_key_id] = ""
# Google Secret Access Key
default[:virtualmonkey][:fog][:google_secret_access_key] = ""
# Azure Access Key ID
default[:virtualmonkey][:fog][:azure_access_key_id] = ""
# Azure Secret Access Key
default[:virtualmonkey][:fog][:azure_secret_access_key] = ""
# S3 Bucket Name for Reports Storage
default[:virtualmonkey][:fog][:s3_bucket] = ""
# Openstack Folsom Access Key ID
default[:virtualmonkey][:fog][:openstack_access_key_id] = ""
# Openstack Folsom Secret Access Key
default[:virtualmonkey][:fog][:openstack_secret_access_key] = ""
# Openstack Auth URL
default[:virtualmonkey][:fog][:openstack_auth_url] = ""
# Rackspace Private Access Key ID
default[:virtualmonkey][:fog][:raxprivatev3_access_key_id] = ""
# Rackspace Private Secret Access Key
default[:virtualmonkey][:fog][:raxprivatev3_secret_access_key] = ""
# Rackspace Private Auth URL
default[:virtualmonkey][:fog][:raxprivatev3_auth_url] = ""
# HP Access Key ID
default[:virtualmonkey][:fog][:hp_access_key_id] = ""
# HP Secret Access Key
default[:virtualmonkey][:fog][:hp_secret_access_key] = ""
# HP Auth URL
default[:virtualmonkey][:fog][:hp_auth_url] = ""

# Git Settings

# Git Username
default[:virtualmonkey][:git][:user] = ""
# Git Email
default[:virtualmonkey][:git][:email] = ""
# Git SSH Key
default[:virtualmonkey][:git][:ssh_key] = ""
# Git Hostname
default[:virtualmonkey][:git][:host_name] = ""

# Rest Connection Settings

# RightScale Password
default[:virtualmonkey][:rest][:right_passwd] = ""
# RightScale Email
default[:virtualmonkey][:rest][:right_email] = ""
# RightScale Account ID
default[:virtualmonkey][:rest][:right_acct_id] = ""
# RightScale Subdomain
default[:virtualmonkey][:rest][:right_subdomain] = ""
# SSH Key Used by Rest Connection
default[:virtualmonkey][:rest][:ssh_key] = ""
# Public Key for allowing connections from
default[:virtualmonkey][:rest][:ssh_pub_key] = ""
# Rest Connection Repository URL
default[:virtualmonkey][:rest][:repo_url] = ""
# Rest Connection Repository Branch
default[:virtualmonkey][:rest][:repo_branch] = ""

# Test Specific Configuration Settings

# Knife PEM Key used by Chef Client Tests
default[:virtualmonkey][:test_config][:knife_pem_key] = ""

# VirtualMonkey Settings

# VirtualMonkey Repository URL
default[:virtualmonkey][:virtualmonkey][:monkey_repo_url] = ""
# VirtualMonkey Repository Branch
default[:virtualmonkey][:virtualmonkey][:monkey_repo_branch] = ""
# Collateral Repository URL
default[:virtualmonkey][:virtualmonkey][:collateral_repo_url] = ""
# Collateral Repository Branch
default[:virtualmonkey][:virtualmonkey][:collateral_repo_branch] = ""
# Right API Objects Repository URL
default[:virtualmonkey][:virtualmonkey][:right_api_objects_repo_url] = ""
# Right API Objects Repository Branch
default[:virtualmonkey][:virtualmonkey][:right_api_objects_repo_branch] = ""

# RocketMonkey Settings

# RocketMonkey Repository URL
default[:virtualmonkey][:rocketmonkey][:repo_url] = ""
# RocketMonkey Repository Branch
default[:virtualmonkey][:rocketmonkey][:repo_branch] = ""

# Recommended attributes
#

# Gems required for rest_connection
default[:virtualmonkey][:rest][:gem_packages] = {
  "rake" => "10.0.3",
  "bundler" => "1.2.3",
  "ruby-debug" => "0.10.4",
  "gemedit" => "1.0.1",
  "diff-lcs" => "1.1.3",
  "rspec" => "2.12.0",
  "json" => "1.7.7"
}

# Monkey user
default[:virtualmonkey][:user] = "root"
# Monkey user's home directory
default[:virtualmonkey][:user_home] = "/root"
# Monkey group
default[:virtualmonkey][:group] = "root"
# Rest connection path
default[:virtualmonkey][:rest_connection_path] =
  "#{node[:virtualmonkey][:user_home]}/rest_connection"
# Virtualmonkey path
default[:virtualmonkey][:virtualmonkey_path] =
  "#{node[:virtualmonkey][:user_home]}/virtualmonkey"
# Rocketmonkey path
default[:virtualmonkey][:rocketmonkey_path] =
  "#{node[:virtualmonkey][:user_home]}/rocketmonkey"
# The version for the rubygems-update gem
default[:virtualmonkey][:rubygems_update_version] = "1.8.24"
# The version of right_cloud_api rubygem to install
default[:virtualmonkey][:right_cloud_api_version] = "0.0.1"

# Optional Attributes

# Azure Hack on/off
default[:virtualmonkey][:rest][:azure_hack_on] = ""
# Azure Hack Retry Count
default[:virtualmonkey][:rest][:azure_hack_retry_count] = ""
# Azure Hack Sleep Seconds
default[:virtualmonkey][:rest][:azure_hack_sleep_seconds] = ""
# API Logging on/off
default[:virtualmonkey][:rest][:api_logging] = ""
# legacy shard setting
default['virtualmonkey']['rest']['legacy_shard'] = 'false'

# Calculated Attributes

# Azure Endpoint is calculated from the Access Key ID
default[:virtualmonkey][:fog][:azure_endpoint] = "https://" +
  "#{node[:virtualmonkey][:fog][:azure_access_key_id]}.blob.core.windows.net"

# AWS Default SSH Keys
default['virtualmonkey']['aws_default_ssh_key_ids']['east'] = '20578'
default['virtualmonkey']['aws_default_ssh_key_ids']['eu'] = '324202'
default['virtualmonkey']['aws_default_ssh_key_ids']['us_west'] = '173773'
default['virtualmonkey']['aws_default_ssh_key_ids']['ap_singapore'] = '324203'
default['virtualmonkey']['aws_default_ssh_key_ids']['ap_tokyo'] = '324190'
default['virtualmonkey']['aws_default_ssh_key_ids']['us_oregon'] = '255379001'
default['virtualmonkey']['aws_default_ssh_key_ids']['sa_sao_paolo'] = '216453001'
default['virtualmonkey']['aws_default_ssh_key_ids']['ap_sydney'] = '323389001'

# ruby version
default['virtualmonkey']['ruby']['version'] = '1.9'
