module Test
  module HumbleUnit
    module Runners
      module TestMethodRunner
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
        def messages
          @messages ||= []
        end

        def call_test_methods
          messages.clear

          test_methods_to_call.each do |method|
            message = Core::OutputMessage.new method(method)

            begin
              self.send(setup_method) if setup_method
              self.send(method)
              self.send(teardown_method) if teardown_method
              message.pass = true
            rescue Errors::AssertionError => e
              message.error = e.message
            ensure
              messages << message
            end
          end
        end
      end
    end
  end
end