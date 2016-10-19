# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.define "mezuro" do |mezuro|
    mezuro.vm.box = "debian/jessie64"
    mezuro.vm.network "private_network", ip: "10.18.0.115"
  end
  config.vm.provider "libvirt" do |v|
    v.memory = 2048
  end
  config.vm.provision "shell" do |s|
		ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
		s.inline = <<-SHELL
		echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
		mkdir -p /root/.ssh
		echo #{ssh_pub_key} >> /root/.ssh/authorized_keys
		SHELL
	end

end
