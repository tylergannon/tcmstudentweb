require 'test_helper'

class PointPrescriptionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:point_prescriptions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create point_prescription" do
    assert_difference('PointPrescription.count') do
      post :create, :point_prescription => point_prescriptions(:one).attributes
    end

    assert_redirected_to point_prescription_path(assigns(:point_prescription))
  end

  test "should show point_prescription" do
    get :show, :id => point_prescriptions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => point_prescriptions(:one).to_param
    assert_response :success
  end

  test "should update point_prescription" do
    put :update, :id => point_prescriptions(:one).to_param, :point_prescription => point_prescriptions(:one).attributes
    assert_redirected_to point_prescription_path(assigns(:point_prescription))
  end

  test "should destroy point_prescription" do
    assert_difference('PointPrescription.count', -1) do
      delete :destroy, :id => point_prescriptions(:one).to_param
    end

    assert_redirected_to point_prescriptions_path
  end
end
