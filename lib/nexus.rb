Dir[File.dirname(__FILE__) + "/nexus/*.rb"].each { |file| require file }

require "yaml"
require_relative "string"

module Titon
    module Nexus
        VERSION = File.read(File.expand_path("../../version.md", __FILE__))

        class Console
            def self.isInitialized()
                return Dir.exists?(File.expand_path("../../.nexus/", __FILE__))
            end

            def self.getYamlConfigPath()
                return File.expand_path("../../.nexus/nexus.yml", __FILE__)
            end

            def self.loadYamlConfig()
                return YAML.load_file(getYamlConfigPath())
            end

            def self.updateYamlConfig(data)
                return File.open(getYamlConfigPath(), "w") { |f| f.write(data) }
            end

            def self.runVagrantCommand(command)
                Dir.chdir(File.expand_path("../../", __FILE__)) {
                    system("vagrant #{command}")
                }
            end
        end
    end
end
