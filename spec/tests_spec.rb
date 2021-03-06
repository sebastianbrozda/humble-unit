require "test/unit"
require_relative '../lib/test/humble_unit/mixins/assertions'
require_relative '../lib/test/humble_unit/test_case'
require_relative '../lib/test/humble_unit/errors/assertion_error'

class Tests < Test::Unit::TestCase
  include Test::HumbleUnit::Mixins::Assertions

  def test_eq
    assert_nothing_raised { expect(6).to(be_eq(6)) }
  end

  def test_eq_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) { expect(5).to(be_eq(6)) }
  end

  def test_eq_delta
    assert_nothing_raised { expect(6.05).to(be_eq(6.055, 0.005)) }
  end

  def test_eq_delta_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) { expect(6.01).to(be_eq(6.0111, 0.001)) }
  end

  def test_greater
    assert_nothing_raised { expect(10).to(be_greater(4)) }
  end

  def test_greater_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) { expect(-10).to(be_greater(4)) }
  end

  def test_greater_or_equal
    assert_nothing_raised { expect(10).to(be_greater_or_equal(10)) }
    assert_nothing_raised { expect(10).to(be_greater_or_equal(11)) }
  end

  def test_greater_or_equal_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) { expect(10).to(be_greater_or_equal(9)) }
  end

  def test_less
    assert_nothing_raised { expect(5).to(be_less(10)) }
  end

  def test_less_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) { expect(5).to(be_less(1)) }
  end

  def test_less_or_equal
    assert_nothing_raised { expect(10).to(be_less_or_equal(10)) }
    assert_nothing_raised { expect(10).to(be_less_or_equal(9)) }
  end

  def test_less_or_equal_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) { expect(10).to(be_less_or_equal(11)) }
  end

  def test_raise_error
    assert_nothing_raised do
      expect(lambda { raise "Error" }).to(raise_error)
    end
  end

  def test_raise_error_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) do
      expect(lambda { 3 + 3 }).to(raise_error)
    end
  end

  def test_not_to
    assert_nothing_raised { expect(5).not_to(be_eq(7)) }
  end

  def test_not_to_fails
    assert_raise(Test::HumbleUnit::Errors::AssertionError) do
      expect(lambda { raise "Error" }).not_to(raise_error)
    end
  end
end