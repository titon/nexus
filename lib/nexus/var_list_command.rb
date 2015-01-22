require "table_print"

module Titon
    module Nexus
        class VarListCommand < ::Escort::ActionCommand::Base
            def execute
                yaml = Titon::Nexus::Console.loadYamlConfig()

                if !yaml["vars"]
                    puts "No environment variables defined".yellow
                    return
                end

                puts "Environment Variables\n".green

                tp(yaml["vars"])
            end
        end
    end
end