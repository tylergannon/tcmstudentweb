require 'test_helper'

class PulseQualityTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert PulseQuality.new.valid?
  end
end
