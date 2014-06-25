module Test
  module HumbleUnit
    module Outputs
      class FileOutput < BaseOutput
        require 'fileutils'

        def flush(messages)
          build_content(messages)
          create_report_directory
          write_content_to_file
        end

        private

        DIRECTORY_NAME = "humble_file_reports"

        def build_content(messages)
          @content = ''
          messages.each do |m|
            @content += "\r\n#{m.status}: #{m.method_name} (#{m.source_location_file}:#{m.source_location_line_number}) #{m.error}"
          end
        end

        def create_report_directory
          unless File.directory? DIRECTORY_NAME
            FileUtils.mkdir_p DIRECTORY_NAME
          end
        end

        def write_content_to_file
          File.open(filename, "w") do |file|
            file.write(@content)
          end
        end

        def filename
          File.join(DIRECTORY_NAME, "humble_report_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.txt")
        end
      end
    end
  end
end

