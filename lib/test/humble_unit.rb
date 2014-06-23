#require_relative 'humble_unit/errors/assertion_error'
#require_relative 'humble_unit/mixins/test_method_caller'
#require_relative 'humble_unit/mixins/assertions'
#require_relative 'humble_unit/runners/file_runner'
#require_relative 'humble_unit/test_case'


module Test
  module HumbleUnit

    module Errors
      autoload :AssertionError, 'test/humble_unit/errors/assertion_error'
    end

    module Mixins
      autoload :TestMethodCaller, 'test/humble_unit/mixins/test_method_caller'
      autoload :Assertions, 'test/humble_unit/mixins/assertions'
    end

    module Runners
      autoload :FileRunner, 'test/humble_unit/runners/file_runner'
    end

    autoload :TestCase, 'test/humble_unit/test_case'

    TestCase.send(:extend, Test::HumbleUnit::Runners::FileRunner)
    TestCase.run_all_tests
  end
end


