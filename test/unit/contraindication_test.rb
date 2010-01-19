require 'test_helper'

class ContraindicationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Contraindication.new.valid?
  end
end
