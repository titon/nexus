require "fileutils"

module Titon
    module Nexus
        class ExportCommand < ::Escort::ActionCommand::Base
            def execute
                exportPath = File.expand_path("~/.nexus/")
                basePath = File.expand_path("./.nexus/")

                if !Dir.exists?(exportPath)
                    Dir.mkdir(exportPath)
                end

                Dir[basePath + "/*"].each do |file|
                    FileUtils.cp(file, exportPath + "/" + File.basename(file))
                end

                puts "Successfully exported Nexus configuration to ".green + "~/.nexus".yellow
            end
        end
    end
end