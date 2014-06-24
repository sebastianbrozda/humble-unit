module Test
  module HumbleUnit
    module Runners
      module TestRunner
        extend self

        private
        def get_all_testing_classes
          existing_classes = ObjectSpace.each_object(Class).to_a
          require File.expand_path($0)
          new_classes = ObjectSpace.each_object(Class).to_a - existing_classes
          new_classes.select { |k| k < Test::HumbleUnit::TestCase }
        end

        public
        def run_all_tests(output)
          get_all_testing_classes.each do |testing_class|
            testing_class.send(:include, Test::HumbleUnit::Runners::TestMethodRunner)
            instance = testing_class.new
            instance.call_test_methods
            output.flush instance.messages
          end
        end
      end
    end
  end
end