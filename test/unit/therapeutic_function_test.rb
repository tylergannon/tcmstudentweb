require 'test_helper'

class TherapeuticFunctionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert TherapeuticFunction.new.valid?
  end
end
