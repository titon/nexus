module Titon
    module Nexus
        class VarListCommand < ::Escort::ActionCommand::Base
            def execute
                yaml = Titon::Nexus::Console.loadYamlConfig()

                if yaml["vars"] == nil
                    Escort::Logger.output.puts "No environment variables defined"
                    return
                end

                Escort::Logger.output.puts "Environment variables"

                yaml["vars"].each do |var|
                    Escort::Logger.output.puts "- " + var["key"] + "=" + var["value"]
                end
            end
        end
    end
end