require 'test_helper'

class FormulaDuiYaosControllerTest < ActionController::TestCase

  context "on POST to :create" do
    setup do
      @formula = Factory(:formula)
      @formula_dui_yao = Factory.build(:formula_dui_yao, :formula => @formula)
      post :create, :format => "js", :formula_dui_yao => ObjectHasher.hash_formula_dui_yao(@formula_dui_yao)
#      @new_formula_dui_yao = FormulaDuiYao.find_by_formula_id(@formula.id)

    end
    should_assign_to :formula_dui_yao
    should_create :formula_dui_yao
    should_render_template :create
#    should_respond_with :redirect
    should_change("the number of Formula Dui Yaos", :by => 1) {FormulaDuiYao.count}
    should_set_the_flash_to("Dui Yao was successfully added.")
#    should_redirect_to("New Acu Point path") {"/acu_points/#{@new_acu_point.id}"}
  end


end
