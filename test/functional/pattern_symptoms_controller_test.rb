require 'test_helper'

class PatternSymptomsControllerTest < ActionController::TestCase
  test "should get sort" do
    get :sort
    assert_response :success
  end

end
