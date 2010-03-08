require 'test_helper'

class FormulasHelperTest < ActionView::TestCase

  def setup
    @formula = Formula.new
    @formula.formula_symptoms << new_symptom("Backache")
    @formula.formula_symptoms << new_symptom("Stomachache")
    @formula.formula_symptoms << new_symptom("Pain in the neck")

    @text = "Headache;  *BackAche;  -StomachAche; - Pain in the neck"
    @hasher = StringObjectHasher.new @text, @formula.formula_symptoms, FormulaSymptomReader.new(nil)
  end

  def test_first_symptom_is_interpreted
    assert_equal("Headache", @hasher.strings[0])
  end

  def test_formula_symptoms_array_is_created_from_text
    assert_equal("Headache", @hasher.objects[0].name)
  end

  def test_parses_key_symptom
    assert(@hasher.objects[1].obj.key_symptom)
    assert(! @hasher.objects[1].obj.maybe)
  end

  def test_parses_maybe
    assert_equal("Stomachache", @hasher.objects[2].name)
    assert(@hasher.objects[2].obj.maybe)
    assert(! @hasher.objects[2].obj.key_symptom)
  end

  def test_parses_space_between_modifier_and_symptom
    assert(@hasher.objects[3].obj.maybe)
    assert_equal("Pain in the neck", @hasher.objects[3].name)
  end

  def test_find_existing_formula_symptoms_on_formula_object
    backache = @hasher.objects.select{|v| v.name.downcase == "Backache".downcase}[0]
    assert_equal(@formula.formula_symptoms[0].id, backache.id, "FormulaSymptom ID should be same as created in test.")
  end

  def test_create_parameter_hash
    @hash = @hasher.get_hash
    assert_equal(4, @hash.size)
    verify_hash_values(@hash)
  end

  def verify_hash_values(hash)
    assert_equal("Headache", hash["0"][:symptom_name])
    assert_equal("Backache", hash["1"][:symptom_name])
    assert_equal("1", hash["1"][:key_symptom])
    assert_equal("Stomachache", hash["2"][:symptom_name])
    assert_equal("1", hash["2"][:maybe])
    assert_equal("Pain in the neck", hash["3"][:symptom_name])
  end

  def test_create_destroy_records_for_deleted_stuff
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
  def new_symptom(symptom)
    formula_symptom_new = FormulaSymptom.new(:symptom_name => symptom, :key_symptom => false)
    formula_symptom_new.save
    return formula_symptom_new
  end

end

# Headache;  *Backache;  -stomachache; - Pain in the neck