module Titon
    module Nexus
        class VarAddCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    Escort::Logger.output.puts "Variable key required"
                    return
                end

                if !arguments[1]
                    Escort::Logger.output.puts "Variable value required"
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
                    Escort::Logger.output.puts "Added new environment variable " + arguments[0]
                else
                    Escort::Logger.output.puts "Updated environment variable " + arguments[0]
                end
            end
        end
    end
end