module Titon
    module Nexus
        class ProjectDeleteCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    puts "Hostname required".red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()
                index = -1

                # Find the index
                if yaml["projects"] != nil
                    yaml["projects"].each_with_index do |project, i|
                        if project["hostname"] == arguments[0]
                            index = i
                            break
                        end
                    end
                end

                if index == -1
                    puts "No matching hostname to delete".yellow
                    return
                end

                # Delete the project
                yaml["projects"].delete_at(index)

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                puts "Deleted project ".green + arguments[0].yellow
            end
        end
    end
end