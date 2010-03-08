require 'test_helper'

class FormulaCategoriesControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup do
      Factory(:formula_category)
      Factory(:formula_category, :name => "Resolve Exterior")
      get :index, :format => "js", :search => "Resolve Exterior"
    end
    should_assign_to("formula_categories")
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end
end