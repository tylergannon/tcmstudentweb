require 'test_helper'

class TongueQualityTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TongueQuality.new.valid?
  end
end
