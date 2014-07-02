module Test
  module HumbleUnit
    module Outputs
      class ConsoleOutput < BaseOutput
        def flush(test_class_name, messages, stats)
          flush_header test_class_name
          flush_messages test_class_name, messages
          flush_stats stats
        end

        private
        def flush_header test_class_name
          printf "--=== Test class: #{test_class_name} ===---\n".to_brown
          printf "%-10s %-20s %-51s %s\n", "Status", "Method name", "Error", "Source location"
        end

        def flush_messages(test_class_name, messages)
          flush_header test_class_name
          flush_content messages
        end

        def flush_stats(stats)
          printf "%-10s: %-20s\n", "Test result", test_result(stats)
          printf "%-10s: %-20s\n", "Passed", stats.passed_count
          printf "%-10s: %-20s\n", "Failed", stats.failed_count
          printf "%-10s: %-20s\n", "Tests", stats.number_of_tests
          printf "%-10s: %-20s\n", "At", stats.time
          printf "\n"
        end

        def flush_content(messages)
          order_messages(messages).each do |m|
            printf("%-19s %-20s %-60s %s\n", status(m), m.method_name, error(m), "#{m.source_location_file}:#{m.source_location_line_number}")
          end
          printf "\n"
        end

        def status(m)
          m.pass ? m.status.to_green : m.status.to_red
        end

        def error(m)
          m.pass ? m.error.to_green : m.error.to_red
        end

        def test_result(stats)
          percentage = "(#{stats.percentage}/100.0%)"
          stats.all_passed? ? "YES #{percentage}".bg_green : "NO #{percentage}".bg_red
        end
      end
    end
  end
end