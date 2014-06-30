module Test
  module HumbleUnit
    module Outputs
      class ConsoleOutput < BaseOutput
        def flush(test_class_name, messages, stats)
          flush_messages test_class_name, messages
          flush_stats stats
        end

        private
        def flush_messages(test_class_name, messages)
          order_messages(messages).each do |m|
            p "#{test_class_name} - #{m.status}: #{m.method_name} (#{m.source_location_file}:#{m.source_location_line_number}) #{m.error}"
          end
        end

        def flush_stats(stats)
          p "TESTING STATUS: #{stats.all_passed?} | Succeed: #{stats.passed_count} / Failed: #{stats.failed_count} | Tests: #{stats.number_of_tests} at #{stats.time}"
        end
      end
    end
  end
end