require "fileutils"

module Titon
    module Nexus
        class InitCommand < ::Escort::ActionCommand::Base
            def execute
                rootPath = File.expand_path("../../../", __FILE__) + "/"
                configPath = rootPath + "conf/"
                runtimePath = rootPath + ".nexus/"

                if Dir.exists?(runtimePath)
                    puts "Nexus has already been initialized".yellow
                    return
                end

                if Dir.mkdir(runtimePath)
                    FileUtils.cp(configPath + "nexus.yml", runtimePath + "nexus.yml")
                else
                    puts "Failed to create configuration folder".red
                    return
                end

                puts "Successfully initialized Nexus".green
            end
        end
    end
end