# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
	config.vm.box = "loan-wolf"
	config.vm.box_url = "http://vagrant.cichq.com/loan-wolf/current.box"
	config.vm.forward_port 80, 8003
	config.vm.forward_port 3000, 3000
	config.vm.provision :chef_client do |chef|
		chef.environment = "vagrant"
		chef.node_name = "loan-wolf-vagrant"
		chef.chef_server_url = "http://chef.ciclabs.com:4000"
		chef.validation_key_path = "/etc/chef/validation.pem"
		chef.validation_client_name = "chef-validator"
		recipes = [ "cic_projects::project_loan-wolf" ]
		recipes.each do |recipe|
			chef.add_recipe recipe
		end
	end
end
