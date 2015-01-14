Dir[File.dirname(__FILE__) + "/nexus/*.rb"].each { |file| require file }

require 'yaml'
require_relative 'colors'

module Titon
    module Nexus
        VERSION = File.read(File.expand_path("../../version.md", __FILE__))

        class Console
            def self.getYamlConfigPath()
                return File.expand_path("../../.nexus/nexus.yml", __FILE__)
            end

            def self.loadYamlConfig()
                return YAML.load_file(getYamlConfigPath())
            end

            def self.updateYamlConfig(data)
                return File.open(getYamlConfigPath(), 'w') { |f| f.write(data) }
            end
        end
    end
end