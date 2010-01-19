require 'test_helper'

class FormulaCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => FormulaCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    FormulaCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    FormulaCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to formula_category_url(assigns(:formula_category))
  end
  
  def test_edit
    get :edit, :id => FormulaCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    FormulaCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => FormulaCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    FormulaCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => FormulaCategory.first
    assert_redirected_to formula_category_url(assigns(:formula_category))
  end
  
  def test_destroy
    formula_category = FormulaCategory.first
    delete :destroy, :id => formula_category
    assert_redirected_to formula_categories_url
    assert !FormulaCategory.exists?(formula_category.id)
  end
end
