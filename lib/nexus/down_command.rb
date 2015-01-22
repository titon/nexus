module Titon
    module Nexus
        class DownCommand < ::Escort::ActionCommand::Base
            def execute
                puts "Stopping Vagrant...\n".green

                Titon::Nexus::Console.runVagrantCommand("halt")
            end
        end
    end
end