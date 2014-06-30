module Test
  module HumbleUnit
    module Outputs
      class FileOutput < BaseOutput
        require 'fileutils'

        def flush(test_class_name, messages, stats)
          content = build_header(test_class_name)
          content += build_content(messages, stats)
          create_report_directory
          write_content_to_file test_class_name, content
        end

        private
        def build_header(test_class_name)
          "Testing class: #{test_class_name} (by HumbleUnit)"
        end

        def directory_name
          "humble_file_reports"
        end

        def report_ext
          ".txt"
        end

        def build_content(messages, stats)
          content = build_messages messages
          content += build_stats stats
          content
        end

        def build_messages(messages)
          content = ''
          order_messages(messages).each do |m|
            content += "\n#{m.status}:\t#{m.method_name}\t#{m.error}\t#{m.source_location_file}:#{m.source_location_line_number}"
          end
          content
        end

        def build_stats(stats)
          content = "\nTest result: #{test_result(stats)}"
          content << "\nPassed: #{stats.passed_count}"
          content << "\nFailed: #{stats.failed_count}"
          content << "\nTests: #{stats.number_of_tests}"
          content << "\nAt: #{stats.time}"
          content
        end

        def test_result(stats)
          percentage = "(#{stats.percentage}/100.0%)"
          stats.all_passed? ? "YES #{percentage}" : "NO #{percentage}"
        end

      end
    end
  end
end

