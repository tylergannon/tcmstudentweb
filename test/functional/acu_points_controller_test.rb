require 'test_helper'

class AcuPointsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:acu_points)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create acu_point" do
    assert_difference('AcuPoint.count') do
      post :create, :acu_point => { }
    end

    assert_redirected_to acu_point_path(assigns(:acu_point))
  end

  test "should show acu_point" do
    get :show, :id => acu_points(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => acu_points(:one).to_param
    assert_response :success
  end

  test "should update acu_point" do
    put :update, :id => acu_points(:one).to_param, :acu_point => { }
    assert_redirected_to acu_point_path(assigns(:acu_point))
  end

  test "should destroy acu_point" do
    assert_difference('AcuPoint.count', -1) do
      delete :destroy, :id => acu_points(:one).to_param
    end

    assert_redirected_to acu_points_path
  end
end
