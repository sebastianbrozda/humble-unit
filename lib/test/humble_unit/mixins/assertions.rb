module Test
  module HumbleUnit
    module Mixins
      module Assertions
        def expect(expected_val)
          @expected_val = expected_val
          self
        end

        def to result
          raise Errors::AssertionError, error_message if !result
        end

        def not_to result
          raise Errors::AssertionError if result
        end

        def be_eq val, delta = 0
          return if (val.to_f - @expected_val.to_f).abs > delta.to_f
          true
        end

        def be_greater val
          return if @expected_val <= val
          true
        end

        def be_greater_or_equal val
          return if @expected_val > val
          true
        end

        def be_less val
          return if @expected_val >= val
          true
        end

        def be_less_or_equal val
          return if @expected_val < val
          true
        end

        def raise_error
          if @expected_val.is_a? Proc
            begin
              @expected_val[]
              raise Errors::AssertionError
            rescue Errors::AssertionError
              raise
            rescue
            end
          end
          true
        end

        private
        def error_message
          "expected #{@expected_val}#{delta_error_message} to #{@assertion} but it was #{@current_val}"
        end

        def delta_error_message
          " (delta: #{@delta})" if @delta && @delta > 0
        end
      end

      module Assertions
        def self.before(*method_names, &before_block)
          method_names.each do |name|
            method = instance_method name

            define_method name do |*args, &block|
              instance_exec [args[0], args[1], name], &before_block
              method.bind(self).(*args, &block)
            end
          end
        end

        def self.assert_methods
          instance_methods.select { |m| m.to_s.start_with? 'be_' }
        end

        before(*assert_methods) do |args|
          @current_val, @delta, @assertion = args
        end

        private_class_method :assert_methods
      end
    end
  end
end