require 'test_helper'

class TherapeuticFunctionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => TherapeuticFunction.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    TherapeuticFunction.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    TherapeuticFunction.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to therapeutic_function_url(assigns(:therapeutic_function))
  end
  
  def test_edit
    get :edit, :id => TherapeuticFunction.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    TherapeuticFunction.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TherapeuticFunction.first
    assert_template 'edit'
  end
  
  def test_update_valid
    TherapeuticFunction.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TherapeuticFunction.first
    assert_redirected_to therapeutic_function_url(assigns(:therapeutic_function))
  end
  
  def test_destroy
    therapeutic_function = TherapeuticFunction.first
    delete :destroy, :id => therapeutic_function
    assert_redirected_to therapeutic_functions_url
    assert !TherapeuticFunction.exists?(therapeutic_function.id)
  end
end
