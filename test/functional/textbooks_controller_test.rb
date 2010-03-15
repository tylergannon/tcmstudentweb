require 'test_helper'

class TextbooksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:textbooks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create textbook" do
    assert_difference('Textbook.count') do
      post :create, :textbook => { }
    end

    assert_redirected_to textbook_path(assigns(:textbook))
  end

  test "should show textbook" do
    get :show, :id => textbooks(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => textbooks(:one).to_param
    assert_response :success
  end

  test "should update textbook" do
    put :update, :id => textbooks(:one).to_param, :textbook => { }
    assert_redirected_to textbook_path(assigns(:textbook))
  end

  test "should destroy textbook" do
    assert_difference('Textbook.count', -1) do
      delete :destroy, :id => textbooks(:one).to_param
    end

    assert_redirected_to textbooks_path
  end
end
