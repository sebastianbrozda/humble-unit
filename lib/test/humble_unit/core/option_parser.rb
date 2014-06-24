require 'optparse'
require 'optparse/time'
require 'ostruct'

module Test
  module HumbleUnit
    module Core
      class Parser

        def self.parse(args)
          options = OpenStruct.new
          options.output = 'console'

          opt_parser = OptionParser.new do |opts|
            opts.banner = "Usage: example.rb [options]"

            opts.separator ""
            opts.separator "Specific options:"

            opts.on("-o", "--output [console|file|html]", "Set output type") do |o|
              options.output = o
            end

            opts.on_tail("-h", "--help", "Show this message") do
              puts opts
              exit
            end
          end

          begin
            opt_parser.parse!(args)
            options
          rescue OptionParser::InvalidOption => e
            p "#{e.message}\n\nInvalid option, use --help for a listing of valid options"
          end
        end
      end
    end
  end
end