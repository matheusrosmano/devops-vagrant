# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define "controle" do |controle|
    controle.vm.box = "debian/buster64"
    controle.vm.network "private_network", ip: "172.17.177.100"
    controle.vm.hostname = "controle"
    controle.vm.provider "virtualbox" do |vb|
      vb.name = "controle"
      vb.memory = "1024"
      vb.cpus = 2
      vb.gui = false
      vb.customize ["modifyvm", :id, "--groups", "/vagrant_machines"]
    end
    # controle.vm.provision "shell", inline: "apt update -y && apt install -y vim"
    controle.vm.provision "shell", path: "provision01"
    controle.vm.synced_folder "./configs", "/home/vagrant/devops", owner: "vagrant", group: "vagrant"
  end

  config.vm.define "web" do |web|
    web.vm.box = "debian/buster64"
    web.vm.network "private_network", ip: "172.17.177.101"
    web.vm.hostname = "web"
    web.vm.provider "virtualbox" do |vb|
      vb.name = "web"
      vb.memory = "512"
      vb.cpus = 1
      vb.gui = false
      vb.customize ["modifyvm", :id, "--groups", "/vagrant_machines"]
    end
    web.vm.provision "shell", path: "provision01"
    web.vm.synced_folder "./configs", "/var/configs", owner: "root", group: "root"
  end

  config.vm.define "db" do |db|
    db.vm.box = "debian/buster64"
    db.vm.network "private_network", ip: "172.17.177.102"
    db.vm.hostname = "db"
    db.vm.provider "virtualbox" do |vb|
      vb.name = "db"
      vb.memory = "512"
      vb.cpus = 1
      vb.gui = false
      vb.customize ["modifyvm", :id, "--groups", "/vagrant_machines"]
    end
    db.vm.provision "shell", path: "provision01"
    db.vm.synced_folder "./configs", "/var/configs", owner: "root", group: "root"
  end

  config.vm.define "master" do |master|
    master.vm.box = "centos/8"
    master.vm.network "private_network", ip: "172.17.177.110"
    master.vm.hostname = "master"
    master.vm.provider "virtualbox" do |vb|
      vb.name = "master"
      vb.memory = "1024"
      vb.cpus = 2
      vb.gui = false
      vb.customize ["modifyvm", :id, "--groups", "/vagrant_machines"]
    end
  end

  (1..3).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = "centos/8"
      node.vm.network "private_network", ip: "172.17.177.11#{i}"
      node.vm.hostname = "node#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.name = "node#{i}"
        vb.memory = "512"
        vb.cpus = 1
        vb.gui = false
      end
    end
  end

  config.vm.define "pupmaster" do |pupmaster|
    pupmaster.vm.box = "debian/buster64"
    pupmaster.vm.network "private_network", ip: "172.17.177.105"
    pupmaster.vm.hostname = "pupmaster"
    pupmaster.vm.provider "virtualbox" do |vb|
      vb.name = "pupmaster"
      vb.memory = "2048"
      vb.cpus = 2
      vb.gui = false
      vb.customize ["modifyvm", :id, "--groups", "/vagrant_machines"]
    end
  end

  config.vm.define "pupagent" do |pupagent|
    pupagent.vm.box = "debian/buster64"
    pupagent.vm.network "private_network", ip: "172.17.177.106"
    pupagent.vm.hostname = "pupagent"
    pupagent.vm.provider "virtualbox" do |vb|
      vb.name = "pupagent"
      vb.memory = "512"
      vb.cpus = 1
      vb.gui = false
      vb.customize ["modifyvm", :id, "--groups", "/vagrant_machines"]
    end
    # pupagent.vm.provision "shell", inline: "apt update -y && apt install -y puppet"

    pupagent.vm.synced_folder "./manifests", "/home/vagrant/puppet", owner: "vagrant", group: "vagrant"

    pupagent.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "manifests"
        puppet.manifest_file = "default.pp"
    end
  end
end