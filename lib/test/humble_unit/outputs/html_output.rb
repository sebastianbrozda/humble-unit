module Test
  module HumbleUnit
    module Outputs
      class HtmlOutput < BaseOutput
        require 'fileutils'

        def flush(test_class_name, messages, stats)
          html = build_header test_class_name
          html += build_html(messages, stats)
          create_report_directory
          write_content_to_file test_class_name, html
        end

        private

        def build_header(test_class_name)
          "<h1>Testing class: #{test_class_name} (by HumbleUnit)</h1>"
        end


        def directory_name
          "humble_html_reports"
        end

        def report_ext
          ".html"
        end

        class HtmlBuilder
          attr_reader :html

          def build(messages, stats)
            build_header
            build_messages messages
            build_stats stats
            build_footer
          end

          private

          def build_stats(stats)
            @html += <<-HTML_STATS
              <h3 class="#{HtmlBuilder.css_color_class(stats.all_passed?)}">TESTING STATUS: #{stats.all_passed?} | Succeed: #{stats.passed_count} / Failed: #{stats.failed_count} | Tests: #{stats.number_of_tests} at #{stats.time}</h3>
            HTML_STATS
          end

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

          def build_messages(messages)
            build_table_header
            build_table_body messages
            build_table_footer
          end

          def build_table_header
            @html += <<-HTML_TABLE_HEADER
            <table style="width: 100%" border="1">
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
              <tr class="#{HtmlBuilder.css_color_class(m.pass)}">
                <td>#{m.status}</td>
                <td>#{m.method_name}</td>
                <td>#{m.source_location_file}:#{m.source_location_line_number}</td>
                <td>#{m.error}</td>
              </tr>
              HTML_TABLE_ROW
            end
          end

          def self.css_color_class(pass)
            pass ? 'pass' : 'fail'
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

        def build_html(messages, stats)
          builder = HtmlBuilder.new
          builder.build order_messages(messages), stats
          builder.html
        end

      end
    end
  end
end