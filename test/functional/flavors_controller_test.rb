require 'test_helper'

class FlavorsControllerTest < ActionController::TestCase
  index_js_test("flavor") do
    Factory(:flavor)
  end
end