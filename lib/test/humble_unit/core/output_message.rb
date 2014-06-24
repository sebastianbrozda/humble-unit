module Test
  module HumbleUnit
    module Core
      class OutputMessage
        attr_writer :success, :error
        attr_reader :method_name

        def initialize(method)
          @method_name = method.name
          @source_location = method.source_location
          @success = false
        end

        def status
          @success ? 'SUCCESS' : 'FAIL'
        end

        def error
          @success ? "" : "!#{@error}!"
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