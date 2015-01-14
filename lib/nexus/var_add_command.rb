module Titon
    module Nexus
        class VarAddCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    puts "Variable key required".red
                    return
                end

                if !arguments[1]
                    puts "Variable value required".red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()
                append = true

                # Convert to array
                if yaml["vars"] == nil
                    yaml["vars"] = []
                end

                # Check if it exists and update
                yaml["vars"].each_with_index do |var, i|
                    if var["key"] == arguments[0]
                        append = false

                        yaml["vars"][0]["value"] = arguments[1]

                        break
                    end
                end

                # Append variable
                if append
                    yaml["vars"].push({
                        "key" => arguments[0],
                        "value" => arguments[1]
                    })
                end

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                if append
                    puts "Added new environment variable ".green + arguments[0].yellow
                else
                    puts "Updated environment variable ".green + arguments[0].yellow
                end
            end
        end
    end
end