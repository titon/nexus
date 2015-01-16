module Titon
    module Nexus
        class DbAddCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    puts "Database name required".red
                    return
                end

                if !command_options.mysql && !command_options.pgsql
                    puts "Select either `--mysql` or `--pgsql`".red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()
                type = "mysql"
                append = true

                # Determine type
                if command_options.pgsql
                    type = "pgsql"
                end

                # Convert to array
                if yaml["databases"] == nil
                    yaml["databases"] = []
                end

                # Check if it exists and update
                yaml["databases"].each do |db|
                    if db["name"] == arguments[0]
                        append = false
                        break
                    end
                end

                # Append if it doesn't exist
                if append
                    yaml["databases"].push({
                        "name" => arguments[0],
                        "type" => type
                    })
                end

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                puts "Added new database ".green + arguments[0].yellow

                puts "\nRun `nexus reload` to apply your changes".cyan
            end
        end
    end
end