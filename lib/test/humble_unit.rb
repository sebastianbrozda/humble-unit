module Test
  module HumbleUnit

    module Core
      autoload :Parser, 'test/humble_unit/core/option_parser'
      autoload :OutputMessage, 'test/humble_unit/core/output_message'
      autoload :Statistics, 'test/humble_unit/core/statistics'
    end

    module Errors
      autoload :AssertionError, 'test/humble_unit/errors/assertion_error'
    end

    module Mixins
      autoload :Assertions, 'test/humble_unit/mixins/assertions'
      autoload :Colorize, 'test/humble_unit/mixins/colorize'
    end

    module Runners
      autoload :TestMethodRunner, 'test/humble_unit/runners/test_method_runner'
      autoload :TestRunner, 'test/humble_unit/runners/test_runner'
    end

    module Outputs
      autoload :BaseOutput, 'test/humble_unit/outputs/base_output'
      autoload :FactoryOutput, 'test/humble_unit/outputs/factory_output'
      autoload :ConsoleOutput, 'test/humble_unit/outputs/console_output'
      autoload :FileOutput, 'test/humble_unit/outputs/file_output'
      autoload :HtmlOutput, 'test/humble_unit/outputs/html_output'
    end

    autoload :TestCase, 'test/humble_unit/test_case'

    String.send(:include, Mixins::Colorize)
    options = Core::Parser.parse(ARGV)
    output = Outputs::FactoryOutput.instance.create_from options.output

    TestCase.send(:extend, Test::HumbleUnit::Runners::TestRunner)
    TestCase.run_all_tests(output)
  end
end




