module Titon
    module Nexus
        class VarListCommand < ::Escort::ActionCommand::Base
            def execute
                yaml = Titon::Nexus::Console.loadYamlConfig()

                if yaml["vars"] == nil
                    puts "No environment variables defined".yellow
                    return
                end

                puts "Environment variables".green

                yaml["vars"].each do |var|
                    puts "- " + var["key"].yellow + " = ".gray + var["value"].yellow
                end
            end
        end
    end
end