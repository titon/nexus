require "table_print"

module Titon
    module Nexus
        class DbListCommand < ::Escort::ActionCommand::Base
            def execute
                yaml = Titon::Nexus::Console.loadYamlConfig()

                if !yaml["databases"]
                    puts "No databases defined".yellow
                    return
                end

                puts "Databases\n".green

                tp(yaml["databases"])
            end
        end
    end
end