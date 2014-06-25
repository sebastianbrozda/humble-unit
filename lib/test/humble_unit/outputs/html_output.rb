module Test
  module HumbleUnit
    module Outputs
      class HtmlOutput < BaseOutput
        require 'fileutils'

        def flush(messages)
          build_html(messages)
          create_report_directory
          write_content_to_file
        end

        private

        DIRECTORY_NAME = "humble_html_reports"

        def build_html(messages)
          @content = <<-HTML_HEADER
          <html>
            <head>
              <title>Humble Unit Report</title>
            </head>
            <style>
                .pass { background-color: lightgreen; }
                .fail { background-color: red; }
            </style>
            <body>
          HTML_HEADER
          @content += <<-HTML_TABLE_HEADER
            <table border="1">
              <thead>
                <tr>
                  <th>Status</th>
                  <th>Method</th>
                  <th>Source location</th>
                  <th>Error msg</th>
                </tr>
              </thead>
          HTML_TABLE_HEADER
          messages.each do |m|
            @content += <<-HTML_TABLE_ROW
              <tr class="#{css_row_class(m)}">
                <td>#{m.status}</td>
                <td>#{m.method_name}</td>
                <td>#{m.source_location_file}:#{m.source_location_line_number}</td>
                <td>#{m.error}</td>
              </tr>
            HTML_TABLE_ROW
          end
          @content += <<-HTML_TABLE_FOOTER
            </table>
          HTML_TABLE_FOOTER

          @content += <<-HTML_FOOTER
            </body>
          </html>
          HTML_FOOTER
        end

        def css_row_class(m)
          m.pass ? 'pass' : 'fail'
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
          File.join(DIRECTORY_NAME, "humble_report_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.html")
        end
      end
    end
  end
end