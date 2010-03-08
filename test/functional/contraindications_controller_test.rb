require 'test_helper'

class ContraindicationsControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup do
      Factory(:contraindication)
      @c = Factory(:contraindication, :name => "pregnancy")
      get :index, :format => "js", :search => "pregnancy"
    end
    should_assign_to(:contraindications)
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end
end
