module Test
  module HumbleUnit
    module Core
      class OutputMessage
        attr_writer :error
        attr_reader :method_name
        attr_accessor :pass

        def initialize(method)
          @method_name = method.name
          @source_location = method.source_location
          @pass = false
        end

        def status
          @pass ? 'PASS' : 'FAIL'
        end

        def error
          @pass ? "" : "!#{@error}!"
        end

        def source_location_file
          @source_location[0]
        end

        def source_location_line_number
          @source_location[1]
        end
      end
    end
  end
end