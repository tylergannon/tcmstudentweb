require 'test_helper'

class FormParserTest < ActiveSupport::TestCase

  COMMENTARY = " That really hurts!
And you wish it would stop
but it never goes away!"
  PATTERN_TESTSTR = "Headache
*Neck ache
Pain in the butt
  " + COMMENTARY + "*****
-Stomach Ache
Hernia
  Cool*****
Nice

Seems cool
  Don't you think?*****
"

  context "FormParser when given text descibing PatternSymptoms" do
    setup do
      @pattern_symptoms = FormParser.parse_pattern_symptoms(PATTERN_TESTSTR)
      @pattern = Factory(:pattern)
    end
    should "Generate a set of PatternSymptom objects." do
      assert_instance_of(PatternSymptom, @pattern_symptoms[0], "Parser should return an array of PatternSymptoms.")
      assert_equal("Pain in the butt", @pattern_symptoms[2].symptom_name)
      assert_equal(7, @pattern_symptoms.size, "There should be 7 PatternSymptoms for the 7 listed in the text.")
      assert_equal(COMMENTARY, @pattern_symptoms[2].commentary)

      assert(@pattern_symptoms[1].key_symptom)
    end
  end
  context "Some other text that seems troubled" do
    setup do
      @pattern_symptoms = FormParser.parse_pattern_symptoms(TROUBLE)
      @my_pattern = @pattern_symptoms[2]
    end
    should "Work" do
      puts @pattern_symptoms.inspect
      assert_equal(4, @pattern_symptoms.size)
      assert_equal("Some interesting goodies", @my_pattern.commentary)
      assert(@my_pattern.key_symptom)
    end
  end
  TROUBLE = "Something dumb\r\nSomething else\r\n*Whatever!!!\r\n  Some interesting goodies*****\r\nBut you never know\r\n\r\n\r\n"

end