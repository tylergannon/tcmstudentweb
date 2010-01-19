require 'test_helper'

class TongueQualitiesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => TongueQuality.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    TongueQuality.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    TongueQuality.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to tongue_quality_url(assigns(:tongue_quality))
  end
  
  def test_edit
    get :edit, :id => TongueQuality.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    TongueQuality.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TongueQuality.first
    assert_template 'edit'
  end
  
  def test_update_valid
    TongueQuality.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TongueQuality.first
    assert_redirected_to tongue_quality_url(assigns(:tongue_quality))
  end
  
  def test_destroy
    tongue_quality = TongueQuality.first
    delete :destroy, :id => tongue_quality
    assert_redirected_to tongue_qualities_url
    assert !TongueQuality.exists?(tongue_quality.id)
  end
end
