$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require "test/humble_unit"

class DummnyTests < Test::HumbleUnit::TestCase

  def test_dummy
    expect(6).to(be_eq(6))
  end

end
