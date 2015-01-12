require 'yaml'

Vagrant.configure("2") do |config|
    nexus = YAML.load_file('./conf/nexus.yml')

    # Box
    config.vm.box = "titon/nexus"
    config.vm.hostname = "nexus"

    config.vm.provider "virtualbox" do |vb|
        vb.name = "nexus"
        vb.memory = nexus["memory"]
        vb.cpus = nexus["cpus"]
    end

    # Network
    config.vm.network "private_network", ip: nexus["ip"]

    # Port Forwarding
    config.vm.network "forwarded_port", guest: 80, host: 8008
    config.vm.network "forwarded_port", guest: 443, host: 4043
    config.vm.network "forwarded_port", guest: 3306, host: 30306
    config.vm.network "forwarded_port", guest: 5432, host: 50432

    # Sync Folders
    nexus["folders"].each do |folder|
        config.vm.synced_folder folder["from"], folder["to"], :mount_options => ["dmode=777", "fmode=666"]
    end

    # Setup Sites

    # Setup SSH

    # Setup Environment Variables
end
