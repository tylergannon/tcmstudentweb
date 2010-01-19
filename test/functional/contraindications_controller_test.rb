require 'test_helper'

class ContraindicationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Contraindication.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Contraindication.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Contraindication.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to contraindication_url(assigns(:contraindication))
  end
  
  def test_edit
    get :edit, :id => Contraindication.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Contraindication.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Contraindication.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Contraindication.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Contraindication.first
    assert_redirected_to contraindication_url(assigns(:contraindication))
  end
  
  def test_destroy
    contraindication = Contraindication.first
    delete :destroy, :id => contraindication
    assert_redirected_to contraindications_url
    assert !Contraindication.exists?(contraindication.id)
  end
end
