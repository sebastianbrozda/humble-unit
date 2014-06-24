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
    expect(6).to(be_eq(@calc.add(2, 3)))
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
    expect(6).to(be_eq(@calc.add(2, 4)))
  end

end


