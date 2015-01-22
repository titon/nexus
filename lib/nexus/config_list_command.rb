module Titon
    module Nexus
        class ConfigListCommand < ::Escort::ActionCommand::Base
            def execute
                yaml = Titon::Nexus::Console.loadYamlConfig()

                puts "Configuration Settings\n".green

                puts "Provider: " + yaml["provider"].yellow + "\n"
                puts "IP: " + yaml["ip"].yellow + "\n"
                puts "Memory: " + yaml["memory"].to_s.yellow + "\n"
                puts "CPUs: " + yaml["cpus"].to_s.yellow + "\n"
                puts "Aliases File: " + yaml["aliases"].yellow
            end
        end
    end
end