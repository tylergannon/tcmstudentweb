require 'test_helper'

class PatternsControllerTest < ActionController::TestCase
  index_js_test("pattern") {}

  context "on GET to :index" do
    setup do
      get :index
    end
    should_respond_with :success
    should_render_template :index
    should_not_set_the_flash
  end

  context "on GET to :new" do
    setup do
      @user = Factory.build(:user)

      sess = UserSession.create(@user)
      assert sess, "Should be able to log in."
#      puts sess.inspect
      get :new
    end
    should_render_template :new
    should_respond_with :success
  end

  PCT_EXTRA = {"treatment_principles" => "Raises the yang; Resolves the exterior",
           "symptoms" => "*Headache; -Insomnia (difficult to sleep)"}

  context "on POST to :create" do
    setup do
      @pattern = Factory.build(:pattern, :name => "Liver Qi Stagnation")
      post :create, :pattern => ObjectHasher.hash_pattern(@pattern), :extra => {"symptoms" => SYMPTOMS_TEXT}
      @new_pattern = Pattern.find_by_name("Liver Qi Stagnation")
      assert_instance_of(Pattern, @new_pattern)
    end
    should_assign_to :pattern
    should_create :pattern
    should_respond_with :redirect
    should_change("the number of patterns", :by => 1) {Pattern.count}
    should_set_the_flash_to("Pattern was successfully created.")
    should_redirect_to("New pattern path") {"/patterns/#{@new_pattern.id}"}


    should "Create new PatternSymptom objects." do
      assert(@new_pattern.pattern_symptoms.select{|v| v.symptom_name=="Nice"}[0])
      assert(@cool = @new_pattern.pattern_symptoms.select{|v| v.symptom_name=="Pain in the butt"}[0])
      assert_equal(COMMENTS, @cool.commentary)

      assert(@cool = @new_pattern.pattern_symptoms.select{|v| v.symptom_name=="Neck ache"}[0])
      assert(@cool.key_symptom)

      assert(@cool = @new_pattern.pattern_symptoms.select{|v| v.symptom_name=="Stomach Ache"}[0])
      assert(@cool.maybe)

    end


#    should "Add treatment principles and symptoms to new formula" do
#      assert(@new_pattern.pattern_treatment_principles.size > 0, "Should have therapeutic functions")
#      assert(@new_pattern.pattern_treatment_principles.detect{|v| v.treatment_principle_name == "Raises the yang"}, "Should raise yang.")
#      assert(@new_pattern.pattern_symptoms.detect{|v| v.symptom_name == "Headache"}, "Should have Headache")
#    end
  end


  context "on GET to :show" do
    setup do
      @new_pattern = Factory.create(:pattern)
      get :show, :id => @new_pattern.id
    end
    should_respond_with :success
    should_render_template :show
  end

  context "on POST to :update" do
    setup do
      @new_pattern = Factory(:pattern)
      post :update, :id => @new_pattern.id, \
        :formula => ObjectHasher.hash_pattern(@new_pattern), \
        :extra => ""

    end
    should_assign_to :pattern
    should_respond_with :redirect
    should_set_the_flash_to("Pattern was successfully updated.")
    should_redirect_to("New pattern path") {"/patterns/#{@new_pattern.id}"}
  end

  context "on GET to :edit" do
    setup do
      @new_pattern = Factory(:pattern)
      get :edit, :id => @new_pattern.id
    end
    should_assign_to :pattern
    should_respond_with :success
    should_not_set_the_flash
    should_render_template :edit
  end

  context "on CREATE some funky text" do
    setup do
      @new_pattern = Factory(:pattern)
      post :update, :id => @new_pattern.id, \
        :formula => ObjectHasher.hash_pattern(@new_pattern), \
        :extra => {"symptoms" => BROKEN_TEXT}

    end
    should_assign_to :pattern
    should_respond_with :redirect
    should_set_the_flash_to("Pattern was successfully updated.")
    should_redirect_to("New pattern path") {"/patterns/#{@new_pattern.id}"}

  end


  COMMENTS = " That really hurts!
And you wish it would stop
but it never goes away!"

  SYMPTOMS_TEXT = "Headache
*Neck ache
Pain in the butt
  " + COMMENTS + "

-Stomach Ache
Hernia
  Cool

Nice

Seems cool
  Don't you think?

"

BROKEN_TEXT = "Headache
*Neck Ache
-Pain in the butt
  That really hurts!



"
end
