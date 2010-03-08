require 'test_helper'

class ChannelsControllerTest < ActionController::TestCase
  index_js_test("channel") do
    Factory(:channel)
  end
end