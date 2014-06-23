module Test
  module HumbleUnit
    module Runners
      module FileRunner
        extend self

        private
        def get_all_testing_classes
          existing_classes = ObjectSpace.each_object(Class).to_a
          require File.expand_path($0)

          new_classes = ObjectSpace.each_object(Class).to_a - existing_classes
          new_classes.select { |k| k < Test::HumbleUnit::TestCase }
        end

        public
        def run_all_tests
          get_all_testing_classes.each do |testing_class|
            testing_class.send(:include, Test::HumbleUnit::Mixins::TestMethodCaller)
            instance = testing_class.new
            instance.call_test_methods
          end
        end
      end
    end
  end
end
