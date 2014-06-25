module Test
  module HumbleUnit
    module Outputs
      class HtmlOutput < BaseOutput
        require 'fileutils'

        def flush(messages)
          html = build_html(messages)
          create_report_directory
          write_content_to_file html
        end

        private

        DIRECTORY_NAME = "humble_html_reports"

        class HtmlBuilder
          attr_reader :html

          def build(messages)
            build_header
            build_table messages
            build_footer
          end

          private
          def build_header
            @html = <<-HTML_HEADER
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
          end

          def build_table(messages)
            build_table_header
            build_table_body messages
            build_table_footer
          end

          def build_table_header
            @html += <<-HTML_TABLE_HEADER
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
          end

          def build_table_body(messages)
            messages.each do |m|
              @html += <<-HTML_TABLE_ROW
              <tr class="#{css_row_class(m)}">
                <td>#{m.status}</td>
                <td>#{m.method_name}</td>
                <td>#{m.source_location_file}:#{m.source_location_line_number}</td>
                <td>#{m.error}</td>
              </tr>
              HTML_TABLE_ROW
            end
          end

          def css_row_class(m)
            m.pass ? 'pass' : 'fail'
          end

          def build_table_footer
            @html += <<-HTML_TABLE_FOOTER
            </table>
            HTML_TABLE_FOOTER
          end

          def build_footer
            @html += <<-HTML_FOOTER
            </body>
          </html>
            HTML_FOOTER
          end
        end

        def build_html(messages)
          builder = HtmlBuilder.new
          builder.build messages
          builder.html
        end

        def create_report_directory
          unless File.directory? DIRECTORY_NAME
            FileUtils.mkdir_p DIRECTORY_NAME
          end
        end

        def write_content_to_file html
          File.open(filename, "w") do |file|
            file.write(html)
          end
        end

        def filename
          File.join(DIRECTORY_NAME, "humble_report_#{DateTime.now.strftime("%Y%m%d_%H%M%S")}.html")
        end
      end
    end
  end
end