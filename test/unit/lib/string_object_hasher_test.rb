require 'test_helper'

class StringObjectHasherTest < ActiveSupport::TestCase
  SYMPTOMS = "Headache; Pain in the neck"
  THERAPEUTIC_FUNCTIONS = "Release the exterior, Course the Liver"

  context "Acu Point object hasher should behave correctly" do
    setup do
      @acu_point = Factory(:acu_point)
      @text = "Headache;  *BackAche;  -StomachAche; - Pain in the neck"
    end
    should "Be true" do
      assert(true)
    end
  end

  context "Formula object hasher should behave correctly." do
    setup do
      @formula = Formula.new
      @formula.formula_symptoms << new_symptom("Backache")
      @formula.formula_symptoms << new_symptom("Stomachache")
      @formula.formula_symptoms << new_symptom("Pain in the neck")

      @text = "Headache;  *BackAche;  -StomachAche; - Pain in the neck"
      @hasher = StringObjectHasher.new @text, @formula.formula_symptoms, FormulaSymptomReader.new(nil)
    end
    should "interpret first symptom" do
      assert_equal("Headache", @hasher.strings[0])
    end
    should "Create array from text." do
      assert_equal("Headache", @hasher.objects[0].name)
    end
    should "Parse the key symptom" do
      assert(@hasher.objects[1].obj.key_symptom)
      assert(! @hasher.objects[1].obj.maybe)
    end
    should "Parse maybe" do
      assert_equal("Stomachache", @hasher.objects[2].name)
      assert(@hasher.objects[2].obj.maybe)
      assert(! @hasher.objects[2].obj.key_symptom)
    end
    should "parse space between modifier and symptom" do
      assert(@hasher.objects[3].obj.maybe)
      assert_equal("Pain in the neck", @hasher.objects[3].name)
    end

    should "find existing formula symptoms on formula object" do
      backache = @hasher.objects.select{|v| v.name.downcase == "Backache".downcase}[0]
      assert_equal(@formula.formula_symptoms[0].id, backache.id, "FormulaSymptom ID should be same as created in test.")
    end

    should "Create parameter hash" do
      @hash = @hasher.get_hash
      assert_equal(4, @hash.size)
      verify_hash_values(@hash)
    end

    should "Create '_destroy' records for deleted stuff." do
      #  Create a FormulaSymptom that doesn't exist in the text.
      a = FormulaSymptom.new(:symptom_name => "Very Painful")
      a.save
      @formula.formula_symptoms << a
      @hasher = StringObjectHasher.new @text, @formula.formula_symptoms, FormulaSymptomReader.new(nil)
      hash = @hasher.get_hash
      assert_equal(5, hash.size)
      verify_hash_values(hash)
      assert_equal("1",                 hash["4"][:_destroy])
    end
  end

  def verify_hash_values(hash)
    assert_equal("Headache", hash["0"]["symptom_name"])
    assert_equal("Backache", hash["1"]["symptom_name"])
    assert_equal("1", hash["1"]["key_symptom"])
    assert_equal("Stomachache", hash["2"]["symptom_name"])
    assert_equal("1", hash["2"]["maybe"])
    assert_equal("Pain in the neck", hash["3"]["symptom_name"])
  end

  def new_symptom(symptom)
    formula_symptom_new = FormulaSymptom.new(:symptom_name => symptom, :key_symptom => false)
    formula_symptom_new.save
    return formula_symptom_new
  end
end