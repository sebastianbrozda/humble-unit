module Test
  module HumbleUnit

    module Core
      autoload :Parser, 'test/humble_unit/core/option_parser'
      autoload :OutputMessage, 'test/humble_unit/core/output_message'
    end

    module Errors
      autoload :AssertionError, 'test/humble_unit/errors/assertion_error'
    end

    module Mixins
      autoload :Assertions, 'test/humble_unit/mixins/assertions'
    end

    module Runners
      autoload :TestMethodRunner, 'test/humble_unit/runners/test_method_runner'
      autoload :TestRunner, 'test/humble_unit/runners/test_runner'
    end

    module Outputs
      autoload :Factory, 'test/humble_unit/outputs/factory'
      autoload :Base, 'test/humble_unit/outputs/base'
      autoload :Console, 'test/humble_unit/outputs/console'
      autoload :File, 'test/humble_unit/outputs/file'
      autoload :Html, 'test/humble_unit/outputs/html'
    end

    autoload :TestCase, 'test/humble_unit/test_case'

    options = Core::Parser.parse(ARGV)
    output = Outputs::Factory.instance.create_from options.output

    TestCase.send(:extend, Test::HumbleUnit::Runners::TestRunner)
    TestCase.run_all_tests(output)
  end
end




