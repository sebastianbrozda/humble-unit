module Test
  module HumbleUnit
    module Outputs
      class FactoryOutput
        require 'singleton'
        include ::Singleton

        def create_from type
          case type
            when '', nil, /console/im
              Outputs::ConsoleOutput.new
            when /file/im
              Outputs::File.new
            when /html/im
              Outputs::HtmlOutput.new
            else
              raise 'Wrong output type, select from the list: console, file or html'
          end
        end
      end
    end
  end
end