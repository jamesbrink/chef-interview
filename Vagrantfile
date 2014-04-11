# -*- mode: ruby -*-
# vi: set ft=ruby :
# encoding: utf-8

Vagrant.configure('2') do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://grahamc.com/vagrant/ubuntu-12.04-omnibus-chef.box"

  config.vm.network :forwarded_port, :guest => 8901, :host => 8901
  config.vm.network :forwarded_port, :guest => 8902, :host => 8902

  config.ssh.forward_agent = true

  config.vm.provision :shell, :inline => 'apt-get -q -y update'

  config.vm.provision :chef_solo do |chef|
    chef.data_bags_path = "data_bags"
    chef.cookbooks_path = "cookbooks"

    # stuff that should be in base box
    chef.add_recipe "vim"
    chef.add_recipe "git"
    chef.add_recipe 'build-essential'
    chef.add_recipe 'supervisor'

    # applications that should be deployed
    chef.add_recipe 'app_alpha'
    chef.add_recipe 'app_beta'

    # instruct "homesick::data_bag" to install dotfiles for the user 'testuser'
    chef.json = {
       :mysql => {
         :server_root_password => ''
       }
    }

    chef.log_level = :debug

  end
end
