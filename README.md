humble-unit
===========

very basic testing framework

DO NOT USE IT IN PRODUCTION! It's just an experiment.

using
===========

To use this micro-"framework" you have to stick to the rules:

* Testing class should inherit from Test::HumbleUnit::TestCase
* Test methods must start with "test_" prefix
* Method "setup" runs before each test
* Method "teardown" runs after each test
* Both this methods aren't required to run

example
===========
```ruby
class ExampleTests < Test::HumbleUnit::TestCase
  # executes before each test
  def setup
    p "setup"
  end

  # executes after each test
  def teardown
    p "teardown"
  end

  def test_example
    expect(5).to(be_eq(5))                  # pass
    expect(5).to(be_greater(5))             # fail
    expect(5).to(be_greater_or_equal(5))    # pass
    expect(5).to(be_less(5))                # fail
    expect(5).to(be_less_or_equal(5))       # pass
  end
end
```

running
===================
raw console output:
ruby filename.rb

with defined output:
ruby filename.rb -o [console|file|html]

run all tests from dictionary:

rake test:all["examples"]

rake test:all["examples", output_type] => rake test:all["examples", "html"]


