require 'test_helper'

class HerbsControllerTest < ActionController::TestCase

  context "on POST to :create" do
    setup do
      herb_attributes = herb.write_attributes
      herb_attributes[:citation_attributes] = {"textbook_title" => "Bensky", "where" => "192"}
      herb_attributes[:citation_attributes] = {"textbook_title" => "Bensky", "where" => "192"}
      herb = Factory.build(:herb, :citation_name => "Bensky (2006)")
      post :create, :herb => ObjectHasher.hash_herb(herb)

    end
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:herbs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create herb" do
    assert_difference('Herb.count') do
      post :create, :herb => { }
    end

    assert_redirected_to herb_path(assigns(:herb))
  end

  test "should show herb" do
    get :show, :id => herbs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => herbs(:one).to_param
    assert_response :success
  end

  test "should update herb" do
    put :update, :id => herbs(:one).to_param, :herb => { }
    assert_redirected_to herb_path(assigns(:herb))
  end

  test "should destroy herb" do
    assert_difference('Herb.count', -1) do
      delete :destroy, :id => herbs(:one).to_param
    end

    assert_redirected_to herbs_path
  end
end
