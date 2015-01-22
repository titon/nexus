require "resolv"

module Titon
    module Nexus
        class ConfigCommand < ::Escort::ActionCommand::Base
            def execute
                if !arguments[0]
                    puts "Setting name required".red
                    return
                end

                key = arguments[0]

                if !arguments[1]
                    puts "Setting value required".red
                    return
                end

                value = arguments[1]

                begin
                    case key
                        when "provider"
                            value = setProvider(value)
                        when "ip"
                            value = setIP(value)
                        when "memory"
                            value = setMemory(value)
                        when "cpus"
                            value = setCPUs(value)
                        when "aliases"
                            value = setAliases(value)
                    else
                        raise "Invalid setting to configure"
                    end
                rescue Exception => e
                    puts e.to_s.red
                    return
                end

                yaml = Titon::Nexus::Console.loadYamlConfig()
                yaml[key] = value

                Titon::Nexus::Console.updateYamlConfig(yaml.to_yaml)

                puts "Updated ".green + key.yellow + " configuration\n".green

                puts "Run `nexus reload` to apply your changes".cyan
            end

            def setProvider(value)
                if value == "virtualbox" or value == "vmware"
                    return value
                end

                raise "Unsupported provider " + value
            end

            def setIP(value)
                if value =~ Resolv::IPv4::Regex or value =~ Resolv::IPv6::Regex
                    return value
                end

                raise "Invalid IP address " + value
            end

            def setMemory(value)
                value = value.to_i

                if value >= 512 and value <= 4096
                    return value
                end

                raise "Memory should be between 512 and 4096"
            end

            def setCPUs(value)
                value = value.to_i

                if value >= 1 and value <= 4
                    return value
                end

                raise "CPU count should be between 1 and 4"
            end

            def setAliases(value)
                path = File.expand_path(value)

                if path and File.exist?(path)
                    return value
                end

                raise "Aliases path does not exist"
            end
        end
    end
end