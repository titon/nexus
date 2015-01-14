require "pathname"

module Titon
    module Nexus
        class ProjectAddCommand < ::Escort::ActionCommand::Base
            def execute
                begin
                    sourcePath = getSourcePath()
                    targetName = getTargetName(sourcePath)
                    targetPath = "/home/vagrant/" + targetName + "/"
                    hostname = getHostname(targetName)
                    webroot = getWebroot(targetPath)

                rescue Exception => e
                    puts e.to_s.red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()

                # Convert to array
                if yaml["projects"] == nil
                    yaml["projects"] = []
                end

                # Make sure the paths haven't been used yet
                begin
                    yaml["projects"].each do |project|
                        if project["source"] == sourcePath
                            raise "Source directory has already been used in another project"
                        end

                        if project["target"] == targetPath
                            raise "Target directory has already been used in another project"
                        end

                        if project["hostname"] == hostname
                            raise "Hostname has already been used in another project"
                        end
                    end
                rescue Exception => e
                    puts e.to_s.red
                    return
                end

                # Save it!
                yaml["projects"].push({
                    "hostname" => hostname,
                    "source" => sourcePath,
                    "target" => targetPath,
                    "webroot" => webroot
                })

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                puts "Added new project\n".green
                puts "Hostname: " + hostname.yellow + "\n"
                puts "Source: " + sourcePath.yellow + "\n"
                puts "Target: " + targetPath.yellow + "\n"
                puts "Webroot: " + webroot.yellow
            end

            def getSourcePath()
                path = arguments[0]

                if !path
                    raise "Source directory required"
                end

                if !Dir.exists?(path)
                    raise "Source directory does not exist"
                end

                if !File.directory?(path)
                    raise "Source path must be a directory"
                end

                return Pathname.new(path).realpath.to_s
            end

            def getTargetName(sourcePath)
                targetName = arguments[1]

                if !targetName
                    targetName = Pathname.new(sourcePath).basename.to_s
                end

                return targetName.strip.gsub(" ", "-").gsub(/[^\w-]/, "")
            end

            def getHostname(targetName)
                hostName = command_options.hostname

                if !hostName
                    hostName = targetName
                end

                hostName = hostName.downcase.strip.gsub(" ", "-").gsub(/[^\w\-\.]/, "")

                if hostName.index(".") == nil
                    hostName += ".app"
                end

                return hostName
            end

            def getWebroot(targetPath)
                webroot = command_options.webroot

                if !webroot
                    webroot = ""
                end

                webroot = webroot.gsub("\\", "/").gsub(/^\/|\/$/, "")

                if webroot
                    webroot + "/"
                end

                return webroot
            end
        end
    end
end