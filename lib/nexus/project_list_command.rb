require "table_print"

module Titon
    module Nexus
        class ProjectListCommand < ::Escort::ActionCommand::Base
            def execute
                yaml = Titon::Nexus::Console.loadYamlConfig()

                if !yaml["projects"]
                    puts "No projects defined".yellow
                    return
                end

                puts "Projects\n".green

                tp yaml["projects"]
            end
        end
    end
end