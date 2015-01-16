module Titon
    module Nexus
        class DbDeleteCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    puts "Database name required".red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()
                index = -1

                # Find the index
                if yaml["databases"] != nil
                    yaml["databases"].each_with_index do |db, i|
                        if db["name"] == arguments[0]
                            index = i
                            break
                        end
                    end
                end

                if index == -1
                    puts "No matching database to delete".yellow
                    return
                end

                # Delete the database
                yaml["databases"].delete_at(index)

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                puts "Deleted database ".green + arguments[0].yellow

                puts "\nRun `nexus reload` to apply your changes".cyan
            end
        end
    end
end