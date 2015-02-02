# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "http://files.vagrantup.com/precise64.box"

  config.vm.define "7" do |db|
    config.vm.provision :shell, :path => "7env.sh"
  end

  config.vm.define "8" do |db|
    config.vm.provision :shell, :path => "8env.sh"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

end
