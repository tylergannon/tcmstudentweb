require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post :create, :author => { "name" => "Coolio" }
    end

    assert_redirected_to author_path(assigns(:author))
  end

  test "should show author" do
    get :show, :id => Factory.create(:author).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Factory.create(:author).id
    assert_response :success
  end

  test "should update author" do
    put :update, :id => Factory.create(:author).id, :author => { }
    assert_redirected_to author_path(assigns(:author))
  end

  context "Delete" do
    should_delete(Author, :author) do
      should_redirect_to("Textbooks path") {textbooks_path}
    end
  end

end
