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
            content += "\n#{m.status}: #{m.method_name} (#{m.source_location_file}:#{m.source_location_line_number}) #{m.error}"
          end
          content
        end

        def build_stats(stats)
          "\nTESTING STATUS#{stats.all_passed?} | Succeed: #{stats.passed_count} / Failed: #{stats.failed_count} | Tests: #{stats.number_of_tests} at #{stats.time}"
        end

      end
    end
  end
end

