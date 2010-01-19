require 'test_helper'

class FormulaCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FormulaCategory.new.valid?
  end
end
