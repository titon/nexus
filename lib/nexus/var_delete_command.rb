module Titon
    module Nexus
        class VarDeleteCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    puts "Variable key required".red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()
                index = -1

                # Find the index
                if yaml["vars"] != nil
                    yaml["vars"].each_with_index do |var, i|
                        if var["key"] == arguments[0]
                            index = i
                            break
                        end
                    end
                end

                if index == -1
                    puts "No matching variable to delete".yellow
                    return
                end

                # Delete the variable
                yaml["vars"].delete_at(index)

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                puts "Deleted environment variable ".green + arguments[0].yellow
            end
        end
    end
end