```
 __   __   ______   __  __   __  __   ______
/\ '-.\ \ /\  ___\ /\_\_\_\ /\ \/\ \ /\  ___\
\ \ \-.. \\ \  __\ \/_/\_\/_\ \ \_\ \\ \____ \
 \ \_\. \_\\ \_____\ /\_\/\_\\ \_____\\/\_____\
  \/_/ \/_/ \/_____/ \/_/\/_/ \/_____/ \/_____/
```

# Nexus v0.2.0 #

Titon Nexus is an official Vagrant box that provides an easy to use development environment that comes pre-packaged for HHVM, Hack, and PHP development. It bundles a built-in web server, popular databases, packaging tools, and more.

The Nexus acts as a central hub for *all* your projects and aims to replace the individual `Vagrantfile` per project scenario. It's bundled with a built-in command line tool that aids in the management of projects, databases, Vagrant, and more.

## Minimum Requirements ##

* Vagrant 1.7
* VirtualBox 4.3
* Ruby 1.9

## Box Specifications ##

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

## Upcoming Features ##

* SSH key management
* More database engines
* VMWare support

## Documentation ##

* [Installing](docs/en/installing.md)
* [Configuration](docs/en/configuring.md)
