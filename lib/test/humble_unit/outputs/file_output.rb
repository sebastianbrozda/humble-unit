module Test
  module HumbleUnit
    module Outputs
      class FileOutput < BaseOutput
        require 'fileutils'

        def flush(messages, stats)
          content = build_content(messages, stats)
          create_report_directory
          write_content_to_file content
        end

        private

        DIRECTORY_NAME = "humble_file_reports"

        def build_content(messages, stats)
          content = build_messages messages
          content += build_stats stats
          content
        end

        def build_messages(messages)
          content = ''
          messages.each do |m|
            content += "\n#{m.status}: #{m.method_name} (#{m.source_location_file}:#{m.source_location_line_number}) #{m.error}"
          end
          content
        end

        def build_stats(stats)
          "\nSTATUS: #{stats.all_passed?} | Succeed: #{stats.passed_count} / Failed: #{stats.failed_count} | Tests: #{stats.number_of_tests} at #{stats.time}"
        end

        def create_report_directory
          unless File.directory? DIRECTORY_NAME
            FileUtils.mkdir_p DIRECTORY_NAME
          end
        end

        def write_content_to_file content
          File.open(filename, "w") do |file|
            file.write(content)
          end
        end

        def filename
          File.join(DIRECTORY_NAME, "humble_report_#{DateTime.now.strftime("%Y%m%d_%H%M%S%3N")}.txt")
        end
      end
    end
  end
end

