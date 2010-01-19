require 'test_helper'

class PulseQualitiesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => PulseQuality.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    PulseQuality.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    PulseQuality.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to pulse_quality_url(assigns(:pulse_quality))
  end
  
  def test_edit
    get :edit, :id => PulseQuality.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    PulseQuality.any_instance.stubs(:valid?).returns(false)
    put :update, :id => PulseQuality.first
    assert_template 'edit'
  end
  
  def test_update_valid
    PulseQuality.any_instance.stubs(:valid?).returns(true)
    put :update, :id => PulseQuality.first
    assert_redirected_to pulse_quality_url(assigns(:pulse_quality))
  end
  
  def test_destroy
    pulse_quality = PulseQuality.first
    delete :destroy, :id => pulse_quality
    assert_redirected_to pulse_qualities_url
    assert !PulseQuality.exists?(pulse_quality.id)
  end
end
