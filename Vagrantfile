#!/usr/bin/env ruby

require 'yaml'

Vagrant.configure("2") do |config|
    nexus = YAML.load_file('./.nexus/nexus.yml')

    # Box
    config.vm.box = "titon/nexus"
    config.vm.hostname = "nexus"

    config.vm.provider "virtualbox" do |vb|
        vb.name = "nexus"
        vb.memory = nexus["memory"] ||= 4096
        vb.cpus = nexus["cpus"] ||= 4
    end

    # Network
    config.vm.network "private_network", ip: nexus["ip"] ||= "192.168.13.37"

    # Port Forwarding
    config.vm.network "forwarded_port", guest: 80, host: 8008
    config.vm.network "forwarded_port", guest: 443, host: 4043
    config.vm.network "forwarded_port", guest: 3306, host: 30306
    config.vm.network "forwarded_port", guest: 5432, host: 50432

    # Add Scripts
    config.vm.synced_folder "./bin/", "/home/vagrant/bin/", :mount_options => ["dmode=777", "fmode=666"]

    # Setup Projects
    config.vm.provision "shell", inline: "bash /home/vagrant/bin/cleanup-nginx.sh"

    nexus["projects"].each do |project|
        config.vm.synced_folder project["source"], project["target"], :mount_options => ["dmode=777", "fmode=666"]

        config.vm.provision "shell" do |pv|
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

    config.vm.provision "shell" do |pv|
        pv.inline = "bash /home/vagrant/bin/add-env-vars.sh \"$1\""
        pv.args = [ envVars ]
    end

    # Setup Databases
    nexus["databases"].each do |db|
        config.vm.provision "shell" do |pv|
            pv.inline = "bash /home/vagrant/bin/create-" + db["type"] + "-db.sh $1"
            pv.args = [ db["name"] ]
        end
    end

    # Setup SSH

    # Setup Aliases

    # Update Composer
    config.vm.provision "shell", inline: "/usr/local/bin/composer selfupdate"

    # Restart Services
    config.vm.provision "shell", inline: "bash /home/vagrant/bin/restart-services.sh"
end
