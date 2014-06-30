$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "test/humble_unit"

class Calculator
  def add(a, b)
    a + b
  end
end

class CalculatorTests1 < Test::HumbleUnit::TestCase
  def setup
    @calc = Calculator.new
  end

  def teardown
    p "teardown"
  end

  def test_adding_1
    expect(@calc.add(2, 3)).to(be_eq(6))
  end
end


class CalculatorTests2 < Test::HumbleUnit::TestCase
  def setup
    @calc = Calculator.new
  end

  def teardown
    p "teardown"
  end

  def test_adding_2
    expect(@calc.add(2, 4)).to(be_eq(6))
  end
end



