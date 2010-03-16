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
    get :show, :id => Factory.create(:textbook).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => Factory.create(:textbook).id
    assert_response :success
  end

  test "should update textbook" do
    put :update, :id => Factory.create(:textbook).id, :textbook => {'title' => 'coolio', 'author_name' => 'coolio'}
    assert_redirected_to textbook_path(assigns(:textbook))
  end

  context "on DELETE to :destroy" do
    setup do
      Factory.create(:textbook)
      @textbook = Textbook.last
      @id = @textbook.id
      assert_not_nil(@textbook.id)
      assert Textbook.exists?(@id)
      delete :destroy, :id => @textbook.id
    end
    # should_change("the number of patterns", :by => -1) {Textbook.count}
    should "Delete it" do
      assert !Textbook.exists?(@id)
    end
    should_redirect_to("Textbooks path") {textbooks_path}
  end


end
