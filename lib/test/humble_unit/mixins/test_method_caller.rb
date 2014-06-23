module Test
  module HumbleUnit
    module Mixins
      module TestMethodCaller
        private
        def setup_method
          @setup_method ||= methods.select { |m| m.to_s == "setup" }.first
        end

        def teardown_method
          @teardown_method ||= methods.select { |m| m.to_s == "teardown" }.first
        end

        def test_methods_to_call
          @test_methods_to_call = methods.select { |m| m.to_s.start_with?('test_') }
        end

        public
        def call_test_methods
          test_methods_to_call.each do |method|
            begin
              self.send(setup_method) if setup_method
              self.send(method)
              self.send(teardown_method) if teardown_method
            rescue Errors::AssertionError => ex
              p "ASSERTION ERROR: #{ex.message} in #{method}\r\n#{caller(0).join("\n")} "
            end
          end
        end
      end
    end
  end
end