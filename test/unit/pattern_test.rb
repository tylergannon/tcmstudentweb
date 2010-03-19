require 'test_helper'

class PatternTest < ActiveSupport::TestCase
  context "on update pattern_symptoms_text" do
    setup do
      @pattern = Factory.build(:pattern)
      @pattern.pattern_symptoms = [PatternSymptom.create(:symptom_name => "Headache", :key_symptom => true),
                                   PatternSymptom.create(:symptom_name => "Neckache", :commentary => "Bad", :maybe => true),
                                   PatternSymptom.create(:symptom_name => "Poop")]
      @pattern.save
      @pattern.pattern_symptoms_text = TEST_TEXT
#      puts @pattern.pattern_symptoms.inspect
    end
    should "not contain poop" do
      should_not_contain(@pattern.pattern_symptoms) {|v| v.symptom_name=="Poop"}
      should_contain(@pattern.pattern_symptoms) do |v|
        v.symptom_name == "Neckache"
      end
      should_contain(@pattern.pattern_symptoms) do |v|
        v.symptom_name == "Seems cool"
      end
    end

    should "Convert the other attributes" do
      assert(! pattern_symptom_named("Headache").key_symptom, "Headache should not be marked a key symptom.")
      assert_equal(MY_COMMENTS, pattern_symptom_named("Neckache").commentary, "Neckache should have gotten its comments updated.")
      assert(pattern_symptom_named("Neckache").key_symptom, "Neckache should be key_symptom.")
      assert(!pattern_symptom_named("Neckache").maybe, "Neckache should no longer be maybe..")
    end
  end

  def pattern_symptom_named(name)
    a = @pattern.pattern_symptoms.select{|v| v.symptom_name == name}[0]
    assert_not_nil(a, "PatternSymptom named #{name} should not be nil.")
    a
  end

  MY_COMMENTS = " That really hurts!
And you wish it would stop
but it never goes away!"

  TEST_TEXT = "Headache
*neckache
  " + MY_COMMENTS + "*****
-Stomach Ache
Hernia
  Cool*****
Nice

Seems cool
  Don't you think?*****

"

end
