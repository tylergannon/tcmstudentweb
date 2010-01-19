require 'test_helper'

class HerbCategoryTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert HerbCategory.new.valid?
  end
end
