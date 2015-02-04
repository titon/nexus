# Installation #

There are two ways in using the [Nexus box](https://atlas.hashicorp.com/titon/boxes/nexus). The first approach is using the box directly in your `Vagrantfile` with the box name set to `titon/nexus` -- this approach allows for more granular hands on control. The second approach is through the Nexus hub, which is an all-in-one command line tool for managing multiple projects.

## Per Box ##

To simply use the box, set your Vagrant box to `titon/nexus`.

```ruby
Vagrant.configure("2") do |config|
    config.vm.box = "titon/nexus"
end
```

## Central Hub ##

To use the all-in-one hub, clone the repository to your local machine, preferably in a location where your projects reside, like `~/Sites/`.

```bash
git clone git@github.com:titon/nexus.git
```

Move into the nexus directory and install the gems required by the command line tool.

```bash
cd nexus/
bundle
```

If you don't have Bundler installed, you can install the gems directly.

```bash
gem install 'escort'
gem install 'table_print'
gem install 'win32console' # If you are on Windows
```

Initialize the Nexus environment.

```bash
nexus init
```

If you are on Windows, you may need to pipe the command through ruby to get it working.

```bash
ruby nexus init
```

Before you boot up and provision Vagrant for the first time, [the Nexus environment will need to be configured](configuring.md). 
Help menus can also be accessed from the CLI by passing `--help`.

Once Nexus is configured, boot up Vagrant and wait for it to provision.

```bash
nexus up
```

Once complete, direct your browser to `192.168.13.37`. If everything worked correctly, you should see the following splash screen.
This splash screen will display the current version for each installed technology.

![Nexus](https://s3.amazonaws.com/titon/nexus/splash.png)

## Port Forwarding ##

The following ports have been forwarded to allow guest box access.

<table>
    <thead>
        <tr>
            <td>Tech</td>
            <td>Forwarded To</td>
            <td>Port</td>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>HTTP</td>
            <td>8008</td>
            <td>80</td>
        </tr>
        <tr>
            <td>HTTPS</td>
            <td>4043</td>
            <td>443</td>
        </tr>
        <tr>
            <td>MySQL</td>
            <td>30306</td>
            <td>3306</td>
        </tr>
        <tr>
            <td>PostgreSQL</td>
            <td>50432</td>
            <td>5432</td>
        </tr>
    </tbody>
</table>
