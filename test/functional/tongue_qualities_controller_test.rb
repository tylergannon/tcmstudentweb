require 'test_helper'

class TongueQualitiesControllerTest < ActionController::TestCase
  index_js_test("tongue_quality") do
    Factory(:tongue_quality)
  end
end
