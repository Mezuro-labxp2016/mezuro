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

end
