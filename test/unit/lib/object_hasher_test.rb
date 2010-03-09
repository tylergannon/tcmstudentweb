require 'test_helper'

class ObjectHasherTest < ActiveSupport::TestCase
  context "Should hash AcuPointTherapeuticFunctions correctly" do
    setup do
      @atfhash = ObjectHasher.hash_acu_point_therapeutic_function \
        Factory(:acu_point_therapeutic_function, :therapeutic_function => Factory(:therapeutic_function, :name => "Blah"))
      @ashash = ObjectHasher.hash_acu_point_symptom \
        Factory(:acu_point_symptom, :symptom => Factory(:symptom, :name => "Blah"))
    end
    should "Have correct AcuPoint TherapeuticFunction" do
      assert_equal("Blah", @atfhash["therapeutic_function_name"])
    end

    should "Have correct AcuPoint Symptom" do
      assert_equal("Blah", @ashash["symptom_name"])
    end
  end
end