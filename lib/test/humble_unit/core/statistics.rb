module Test
  module HumbleUnit
    module Core
      class Statistics
        [:passed, :failed].each do |method|
          define_method "#{method}_count" do
            eval "@#{method}_count ||= 0"
          end

          define_method "increment_#{method}" do
            count = send "#{method}_count"
            count += 1
            eval "@#{method}_count = #{count}"
          end
        end

        def number_of_tests
          passed_count + failed_count
        end

        def all_passed?
          failed_count == 0
        end

        def time
          Time.now
        end
      end
    end
  end
end
