#!/usr/bin/env ruby

require "yaml"
require_relative "lib/string"

Vagrant.configure("2") do |config|
    nexus = YAML.load_file("./.nexus/nexus.yml")

    ENV['VAGRANT_DEFAULT_PROVIDER'] = nexus["provider"] ||= "virtualbox"

    # Box
    config.vm.box = "titon/nexus"
    config.vm.hostname = "nexus"

    # Provider
    config.vm.provider "virtualbox" do |vb|
        vb.name = "nexus"
        vb.memory = nexus["memory"] ||= 4096
        vb.cpus = nexus["cpus"] ||= 4
        vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
    end

    # Network
    config.vm.network "private_network", ip: nexus["ip"] ||= "192.168.13.37"

    # Port Forwarding
    config.vm.network "forwarded_port", guest: 80, host: 8008
    config.vm.network "forwarded_port", guest: 443, host: 4043
    config.vm.network "forwarded_port", guest: 3306, host: 30306
    config.vm.network "forwarded_port", guest: 5432, host: 50432

    # Setup SSH
    # config.ssh.private_key_path = nexus["ssh"] ||= "~/.ssh/id_rsa"
    # config.ssh.forward_agent = true

    # Setup Aliases
    aliasPath = File.expand_path(nexus["aliases"])

    if File.exist?(aliasPath)
        config.vm.provision "copy-aliases".green, type: "shell" do |pv|
            pv.inline = "bash /home/vagrant/bin/add-aliases.sh \"$1\""
            pv.args = [ File.read(aliasPath) ]
        end
    end

    # Add Scripts
    config.vm.synced_folder "./bin/", "/home/vagrant/bin/", :mount_options => ["dmode=777", "fmode=666"]
    config.vm.synced_folder "./.nexus/", "/home/vagrant/bin-private/", :mount_options => ["dmode=777", "fmode=666"]

    # Before Provision
    config.vm.provision "before-provision".green, type: "shell", inline: "bash /home/vagrant/bin-private/before-provision.sh"

    # Setup Projects
    config.vm.provision "cleanup-nginx".green, type: "shell", inline: "bash /home/vagrant/bin/cleanup-nginx.sh"

    nexus["projects"].each do |project|
        config.vm.synced_folder project["source"], project["target"], :mount_options => ["dmode=777", "fmode=666"]

        config.vm.provision "add-nginx-host:".green + project["hostname"].yellow, type: "shell" do |pv|
            pv.inline = "bash /home/vagrant/bin/add-nginx-host.sh $1 $2"
            pv.args = [
                project["hostname"],
                project["target"] + project["webroot"]
            ]
        end
    end

    # Setup Environment Variables
    envVars = ""

    nexus["vars"].each do |var|
        envVars += "fastcgi_param  " + var["key"] + "  " + var["value"] + ";\n"
    end

    config.vm.provision "add-env-vars".green, type: "shell" do |pv|
        pv.inline = "bash /home/vagrant/bin/add-env-vars.sh \"$1\""
        pv.args = [ envVars ]
    end

    # Setup Databases
    nexus["databases"].each do |db|
        config.vm.provision "add-database:".green + db["name"].yellow, type: "shell" do |pv|
            pv.inline = "bash /home/vagrant/bin/create-" + db["type"] + "-db.sh $1"
            pv.args = [ db["name"] ]
        end
    end

    # After Provision
    config.vm.provision "after-provision".green, type: "shell", inline: "bash /home/vagrant/bin-private/after-provision.sh"

    # Update Composer
    config.vm.provision "update-composer".green, type: "shell", inline: "/usr/local/bin/composer selfupdate"

    # Restart Services
    config.vm.provision "restart-services".green, type: "shell", inline: "bash /home/vagrant/bin/restart-services.sh"
end
