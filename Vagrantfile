# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = "rightscale-monkey-berkshelf"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "RightImage_Ubuntu_12.04_x64_v13.5.0.1"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://rightscale-vagrant.s3.amazonaws.com/virtualbox/ubuntu/12.04/RightImage_Ubuntu_12.04_x64_v13.5.0.1.box"

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, ip: "33.33.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.

  # config.vm.network :public_network

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # config.ssh.max_tries = 40
  # config.ssh.timeout   = 120

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :mysql => {
        :server_root_password => 'rootpass',
        :server_debian_password => 'debpass',
        :server_repl_password => 'replpass'
      },
      :cloud => {
        :provider => 'vagrant',
        :public_ips => ["127.0.0.1"] 
      }, 
      :rightscale => {
         :instance_uuid => 'vagrant123'
      },
      :virtualmonkey => { 
         :test => {
           :smtp_username => 'WQA_SMTP_USERNAME',
           :smtp_password => 'WQA_SMTP_PASSWORD'
         },
         :virtualmonkey => {
           :right_api_objects_repo_url => 'git@github.com:rightscale/right_api_objects.git',
           :right_api_objects_repo_branch => 'v0.1.2',
           :collateral_repo_url => 'git@github.com:rightscale/rightscale_cookbooks_private.git',
           :collateral_repo_branch => 'white_13_08_acu134591_test_fixes_for_next_gen_collateral',
           :collateral_name => 'rightscale_cookbooks_private'
         },
         :git => {
           :host_name => 'github.com',
           :ssh_key => File.open('.ssh_git_config', 'rb') { |f| f.read } 
         }
      }
  }    
 
   chef.run_list = [
        #"recipe[logging::default]",
        #"recipe[sys_firewall::default]",
        #"recipe[sys_ntp::default]",
        #"recipe[block_device::setup_ephemeral]",
        #"recipe[sys::setup_swap]",
        #"recipe[ruby::install_1_8]",
        "recipe[apt::default]",
        "recipe[virtualmonkey::setup_git]",
        "recipe[virtualmonkey::setup_rest_connection]",
        #"recipe[virtualmonkey::setup_rocketmonkey]",
        "recipe[virtualmonkey::setup_virtualmonkey]",
        "recipe[virtualmonkey::setup_test_config]",
        "recipe[virtualmonkey::update_fog_credentials]",
        #"recipe[virtualmonkey::update_stids]"
        #"recipe[rs-jenkins::default]",
        #"recipe[rs-jenkins::do_attach_slave_at_boot]"
        ]
  end
end
