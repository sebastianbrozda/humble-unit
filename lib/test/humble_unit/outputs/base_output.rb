module Test
  module HumbleUnit
    module Outputs
      class BaseOutput

        def flush(test_class_name, messages, stats)
          raise 'not implemented'
        end

        protected
        def create_report_directory
          unless File.directory? directory_name
            FileUtils.mkdir_p directory_name
          end
        end

        def write_content_to_file(test_class_name, content)
          File.open(filename(test_class_name), "w") do |file|
            file.write(content)
          end
        end

        def directory_name
          raise 'not implemented'
        end

        def report_ext
          raise 'not implemented'
        end

        def order_messages messages
          messages.sort_by { |m| m.pass ? 0 : 1 }
        end

        private
        def filename(test_class_name)
          File.join(directory_name, "#{test_class_name}_#{DateTime.now.strftime("%Y%m%d_%H%M%S%3N")}#{report_ext}")
        end

      end
    end
  end
end