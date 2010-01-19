require 'test_helper'

class HerbCategoriesControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => HerbCategory.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    HerbCategory.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    HerbCategory.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to herb_category_url(assigns(:herb_category))
  end
  
  def test_edit
    get :edit, :id => HerbCategory.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    HerbCategory.any_instance.stubs(:valid?).returns(false)
    put :update, :id => HerbCategory.first
    assert_template 'edit'
  end
  
  def test_update_valid
    HerbCategory.any_instance.stubs(:valid?).returns(true)
    put :update, :id => HerbCategory.first
    assert_redirected_to herb_category_url(assigns(:herb_category))
  end
  
  def test_destroy
    herb_category = HerbCategory.first
    delete :destroy, :id => herb_category
    assert_redirected_to herb_categories_url
    assert !HerbCategory.exists?(herb_category.id)
  end
end
