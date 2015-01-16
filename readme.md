# Nexus #

Titon Nexus is an official Vagrant box that provides an easy to use development environment 
that comes pre-packaged for HHVM and Hack development. It bundles a built-in web server, 
popular databases, packaging tools, and more.

## Requirements ##

* Vagrant 1.7
* VirtualBox
* Ruby 1.9

## Specifications ##

* Ubuntu 14.04
* HHVM Nightly 3.5.0 (PHP 5.6)
* Composer 1.0
* Nginx 1.6.2
* MariaDB 10.0.15 (MySQL)
* PostgreSQL 9.3.5
* Node.js 0.10.25
* NPM 1.3.10
* Redis 2.8.4
* Memcache 1.4.14

## Installation ##

Configure your `Vagrantfile` and use `titon/nexus` as the box.

```ruby
Vagrant.configure("2") do |config|
    config.vm.box = "titon/nexus"
    config.vm.hostname = "nexus"
    config.vm.network "private_network", ip: 192.168.13.37

    # Port Forwarding
    config.vm.network "forwarded_port", guest: 80, host: 8008
    config.vm.network "forwarded_port", guest: 443, host: 4043
    config.vm.network "forwarded_port", guest: 3306, host: 30306
    config.vm.network "forwarded_port", guest: 5432, host: 50432

    # Sync Folders
    config.vm.synced_folder ".", "/vagrant", :mount_options => ["dmode=777", "fmode=666"]
end
```

Run `vagrant up` and visit `192.168.13.37` in your browser.

## Databases ##

Both MySQL and PostgreSQL can be accessed with the user `nexus` and the password `secret`. 
A default database named `nexus` is included.
 
If you used the port forwarding configuration above, you should be able to access the databases through tools outside of the box.

## Nginx ##

To enable a new nginx website, copy the `/etc/nginx/sites-available/nexus` file and change the following properties: 
server_name, root, error_log.

Then symlink the file to enable it and restart nginx.

```
sudo ln -fs /etc/nginx/sites-available/YOURSITE /etc/nginx/sites-enabled/YOURSITE
sudo service nginx restart
```