require 'optparse'
require 'ostruct'

module Titon
    class Nexus
        VERSION = File.read(File.expand_path("../../version.md", __FILE__))

        def initialize()
            @options = OpenStruct.new

            OptionParser.new do |opts|
              opts.banner = "Usage: nexus [options] COMMAND"

              opts.on("--[no-]option VALUE", "Description") { |o| @options[:a] = o }
            end.parse!
        end

        def run()
            puts @options
        end
    end
end