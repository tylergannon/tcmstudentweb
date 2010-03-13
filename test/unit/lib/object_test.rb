require 'test_helper'


class MyClass < ActiveRecord::Base
  attr_accessor :cool, :lame, :stupid
  def self.columns() @columns ||= []; end
  def key_attributes
    ["cool", "lame", "stupid", "id"]
  end
  def name
    stupid
  end
end

class ObjectTest < ActiveSupport::TestCase
  context "New methods for Array class" do
    setup do
      array = ["a", "b", "c"]
      @h = array.to_h {|e| {array.index(e).to_s => e}}
      @a = [Factory(:pattern_symptom),
            (@ps = Factory(:pattern_symptom, :symptom => Factory(:symptom, :name => "Rulio"))),
            Factory(:pattern_symptom)]
      @b = [MyClass.new(:cool=>false, :lame=>true, :stupid=>"Very Stupid"),
            MyClass.new(:cool=>false, :lame=>true, :stupid=>"Less Stupid"),
            MyClass.new(:cool=>true, :lame=>false, :stupid=>"Not Stupid"),
            ]
      @attribute_collection = @b.write_attributes
      @less_stupid = {"cool" => "0", "lame" => "1", "stupid" => "Less Stupid"}
      @very_stupid = {"cool" => "0", "lame" => "1", "stupid" => "Very Stupid"}
      @not_stupid = {"cool" => "1", "lame" => "0", "stupid" => "Not Stupid"}
      @expected_attribute_collection = {"0"=>@very_stupid, "1"=>@less_stupid, "2"=>@not_stupid}
    end
    should "have correct keys in hash" do
      assert_equal("a", @h["0"])
      assert_equal("b", @h["1"])
      assert_equal("c", @h["2"])
    end

    should "find PatternSymptom in collection" do
      assert_equal(@ps, @a.find_same(@ps))
      assert_nil(@a.find_same(PatternSymptom.new(:symptom_name=>"Schoolio")))
    end

    should "hash an object" do
      assert_equal(@very_stupid, @b[0].write_attributes)
    end

    should "hash many objects" do
      assert_equal(@expected_attribute_collection, @attribute_collection)
    end
  end

  context "When writing objects to attribute hash" do
    setup do

      @b = [MyClass.new(:cool=>nil, :lame=>true, :stupid=>"Very Stupid"),
            MyClass.new(:cool=>false, :lame=>true, :stupid=>"Less Stupid"),
            MyClass.new(:cool=>true, :lame=>false, :stupid=>"Not Stupid"),
            ]
      @attribute_collection = @b.write_attributes
      @less_stupid = {"cool" => "0", "lame" => "1", "stupid" => "Less Stupid"}
      @very_stupid = {"lame" => "1", "stupid" => "Very Stupid"}
      @not_stupid = {"cool" => "1", "lame" => "0", "stupid" => "Not Stupid"}
      @expected_attribute_collection = {"0"=>@very_stupid, "1"=>@less_stupid, "2"=>@not_stupid}

      @ps_a = []
    end

    should "not write attributes that are empty or nil" do
      assert_equal(@expected_attribute_collection, @attribute_collection)
    end
  end

  context "Writing an object attribute hash when there are existing objects." do
    setup do

      @old = create_pattern_symptom("One", "Old commentary")
      @new = PatternSymptom.new(:symptom_name => "one", :commentary => "New commentary")
      @new_objects = [build_pattern_symptom("one"), build_pattern_symptom("two"), build_pattern_symptom("three")]
      @old_objects = [create_pattern_symptom("Two"), create_pattern_symptom("Three"), create_pattern_symptom("four")]
      @new << @old

      @attributes = @new_objects.write_attributes(@old_objects)
    end
    should "take on attributes from old." do
      assert(@new =~ @old)
      assert_equal(@new.id, @old.id)
      assert_equal("New commentary", @new.commentary)
      assert_equal("One", @new.symptom_name)
    end

    should "Write attributes for an array of objects" do
      assert_equal("one", @attributes["0"]["symptom_name"])
      assert(!@attributes["0"].has_key?("id"))
      assert(@attributes["1"].has_key?("id"))
      assert(@attributes["2"].has_key?("id"))
      assert(@attributes["3"].has_key?("id"))
      assert_equal("1", @attributes["3"]["_destroy"])
    end

  end

end

