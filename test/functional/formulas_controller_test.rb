require 'test_helper'

class FormulasControllerTest < ActionController::TestCase
  context "on GET to :index" do
    setup do
      get :index
    end
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end

  context "on GET to :new" do
    setup do
      @user = Factory.build(:user)

      sess = UserSession.create(@user)
      assert sess, "Should be able to log in."
#      puts sess.inspect
      get :new
    end
    should_render_template :new
    should_respond_with :success
  end

  EXTRA = {"therapeutic_functions" => "Raises the yang\n Resolves the exterior",
           "symptoms" => "Headache\n Insomnia"}

  context "on POST to :create" do
    setup do
      formula = Factory.build(:formula, :english => "Formula_English")
      post :create, :formula => ObjectHasher.hash_formula(formula), :extra => EXTRA
      @new_formula = Formula.find_by_english("Formula_English")
      assert_instance_of(Formula, @new_formula)
    end
    should_assign_to :formula
    should_create :formula
    should_respond_with :redirect
    should_change("the number of formulas", :by => 1) {Formula.count}
    should_set_the_flash_to("Formula was successfully created.")
    should_redirect_to("New formula path") {"/formulas/#{@new_formula.id}"}

    should "Add therapeutic functions and symptoms to new formula" do
      assert(@new_formula.formula_therapeutic_functions.size > 0, "Should have therapeutic functions")
      assert(@new_formula.formula_therapeutic_functions.detect{|v| v.therapeutic_function_name == "Raises the yang"}, "Should raise yang.")
      assert(@new_formula.formula_symptoms.detect{|v| v.symptom_name == "Headache"}, "Should have Headache")
    end

  end

  context "on GET to :show" do
    setup do
      @new_formula = Factory.create(:formula)
      get :show, :id => @new_formula.id
    end
    should_respond_with :success
    should_render_template :show
  end

  context "on POST to :update" do
    setup do
      @new_formula = Factory(:formula, :english => "Formula_English")
      post :update, :id => @new_formula.id, :formula => ObjectHasher.hash_formula(@new_formula)
    end
    should_assign_to :formula
    should_respond_with :redirect
    should_set_the_flash_to("Formula was successfully updated.")
    should_redirect_to("New formula path") {"/formulas/#{@new_formula.id}"}
  end

  context "on GET to :edit" do
    setup do
      @new_formula = Factory(:formula, :english => "Formula_English")
      get :edit, :id => @new_formula.id
    end
    should_assign_to :formula
    should_respond_with :success
    should_not_set_the_flash
    should_render_template :edit
  end
#
#
#  test "should show formula" do
#    get :show, :id => formulas(:one).to_param
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => formulas(:one).to_param
#    assert_response :success
#  end
#
#  test "should update formula" do
#    put :update, :id => formulas(:one).to_param, :formula => { }
#    assert_redirected_to formula_path(assigns(:formula))
#  end
#
#  test "should destroy formula" do
#    assert_difference('Formula.count', -1) do
#      delete :destroy, :id => formulas(:one).to_param
#    end
#
#    assert_redirected_to formulas_path
#  end
end
