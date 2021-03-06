module Titon
    module Nexus
        class ReloadCommand < ::Escort::ActionCommand::Base
            def execute
                if !Titon::Nexus::Console.isInitialized()
                    puts "Nexus has not been initialized. Please run `nexus init` first.".red
                    return
                end

                puts "Reloading Nexus with configuration changes...\n".green

                Titon::Nexus::Console.runVagrantCommand("reload --provision")
            end
        end
    end
end