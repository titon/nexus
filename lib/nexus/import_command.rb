require "fileutils"

module Titon
    module Nexus
        class ImportCommand < ::Escort::ActionCommand::Base
            def execute
                importPath = File.expand_path("./.nexus/")
                basePath = File.expand_path("~/.nexus/")

                if !Dir.exists?(basePath)
                    puts "No configuration to import".yellow
                    return
                end

                Dir[basePath + "/*"].each do |file|
                    FileUtils.cp(file, importPath + "/" + File.basename(file))
                end

                puts "Successfully imported Nexus configuration from ".green + "~/.nexus".yellow
            end
        end
    end
end