module Titon
    module Nexus
        class UpCommand < ::Escort::ActionCommand::Base
            def execute
                if !Titon::Nexus::Console.isInitialized()
                    puts "Nexus has not been initialized. Please run `nexus init` first.".red
                    return
                end

                puts "Starting Vagrant...\n".green

                Titon::Nexus::Console.runVagrantCommand('up')
            end
        end
    end
end