require 'fileutils'

module Titon
    module Nexus
        class InitCommand < ::Escort::ActionCommand::Base
            def execute
                rootPath = File.expand_path("../../../", __FILE__) + '/'
                configPath = rootPath + "conf/"
                runtimePath = rootPath + ".nexus/"

                if Dir.exists?(runtimePath)
                    Escort::Logger.output.puts "Nexus has already been initialized"
                    return
                end

                if Dir.mkdir(runtimePath)
                    FileUtils.cp(configPath + "nexus.yml", runtimePath + "nexus.yml")
                else
                    Escort::Logger.output.puts "Failed to create configuration folder"
                    return
                end

                Escort::Logger.output.puts "Successfully initialized Nexus"
            end
        end
    end
end