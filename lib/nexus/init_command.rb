require "fileutils"

module Titon
    module Nexus
        class InitCommand < ::Escort::ActionCommand::Base
            def execute
                rootPath = File.expand_path("../../../", __FILE__) + "/"
                runtimePath = rootPath + ".nexus/"

                if Dir.exists?(runtimePath)
                    puts "Nexus has already been initialized".yellow
                    return
                end

                if Dir.mkdir(runtimePath)

                    # Configuration
                    FileUtils.cp(rootPath + "nexus.yml", runtimePath + "nexus.yml")

                    # Before script
                    File.write(runtimePath + "before-provision.sh", "#!/usr/bin/env bash")

                    # After script
                    File.write(runtimePath + "after-provision.sh", "#!/usr/bin/env bash")

                else
                    puts "Failed to create configuration folder".red
                    return
                end

                puts "Successfully initialized Nexus".green
            end
        end
    end
end