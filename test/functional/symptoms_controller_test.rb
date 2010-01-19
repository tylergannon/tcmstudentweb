require 'test_helper'

class SymptomsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Symptom.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Symptom.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Symptom.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to symptom_url(assigns(:symptom))
  end
  
  def test_edit
    get :edit, :id => Symptom.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Symptom.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Symptom.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Symptom.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Symptom.first
    assert_redirected_to symptom_url(assigns(:symptom))
  end
  
  def test_destroy
    symptom = Symptom.first
    delete :destroy, :id => symptom
    assert_redirected_to symptoms_url
    assert !Symptom.exists?(symptom.id)
  end
end
