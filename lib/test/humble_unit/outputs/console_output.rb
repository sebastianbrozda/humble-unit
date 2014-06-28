module Test
  module HumbleUnit
    module Outputs
      class ConsoleOutput < BaseOutput
        def flush(messages, stats)
          messages.each do |m|
            p "#{m.status}: #{m.method_name} (#{m.source_location_file}:#{m.source_location_line_number}) #{m.error}"
          end

          p "STATUS: #{stats.all_passed?} | Succeed: #{stats.passed_count} / Failed: #{stats.failed_count} | Tests: #{stats.number_of_tests} at #{stats.time}"
        end
      end
    end
  end
end