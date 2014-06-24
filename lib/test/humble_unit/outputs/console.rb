module Test
  module HumbleUnit
    module Outputs
      class Console < Base
        def flush(messages)
          messages.each do |m|
            p "#{m.status}: #{m.method_name} (#{m.source_location_file}:#{m.source_location_line_number}) #{m.error}"
          end
        end
      end
    end
  end
end