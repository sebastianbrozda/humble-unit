require 'singleton'

module Test
  module HumbleUnit
    module Outputs
      class Factory
        include ::Singleton

        def create_from type
          case type
            when '', nil, /console/im
              Outputs::Console.new
            when /file/im
              Outputs::File.new
            when /html/im
              Outputs::Html.new
            else
              raise 'Wrong output type, select from the list: console, file or html'
          end
        end
      end
    end
  end
end