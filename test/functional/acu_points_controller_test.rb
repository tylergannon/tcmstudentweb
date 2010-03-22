require 'test_helper'

class AcuPointsControllerTest < ActionController::TestCase

  context "on GET to :index" do
    setup do
      3.times do
        Factory(:acu_point)
      end
      get :index
    end

    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end

  context "on GET to :new" do
    setup do
      get :new
    end
    should_render_template :new
    should_respond_with :success
  end

  context "on POST to :create" do
    setup do
      @acu_point = Factory.build(:acu_point)
      puts ObjectHasher.hash_acu_point(@acu_point).inspect
      assert(@acu_point.valid?, "AcuPoint must be valid for saving, in order for this test to work.")
      post :create, :acu_point => ObjectHasher.hash_acu_point(@acu_point)
      @new_acu_point = AcuPoint.find_by_english(@acu_point.english)
      puts "DUR!!!"
      
      assert_equal(@acu_point.english, AcuPoint.last.english)
      assert_instance_of(AcuPoint, @new_acu_point)
    end
    should_assign_to :acu_point
    should_create :acu_point
    should_respond_with :redirect
    should_change("the number of acu_points", :by => 1) {AcuPoint.count}
    should_set_the_flash_to("Acu Point was successfully created.")
    should_redirect_to("New Acu Point path") {"/acu_points/#{@new_acu_point.id}"}
  end

  context "on GET to :show" do
    setup do
      get :show, :id => Factory.create(:acu_point).id
    end
    should_assign_to :acu_point
    should_respond_with :success
    should_render_template :show
  end

  context "on POST to :update" do
    setup do
      @acu_point = Factory(:acu_point, :english => "Leg Three Mile")
      post :update, :id => @acu_point.id, :formula => @acu_point.attributes
    end
    should_assign_to :acu_point
    should_respond_with :redirect
    should_set_the_flash_to("Acu Point was successfully updated.")
    should_redirect_to("Acu Point path") {"/acu_points/#{@acu_point.id}"}
  end

  context "on GET to :edit" do
    setup do
      @acu_point = Factory(:acu_point, :english => "Leg Three Mile")
      get :edit, :id => @acu_point.id
    end
    should_assign_to :acu_point
    should_respond_with :success
    should_not_set_the_flash
    should_render_template :edit
  end
end
