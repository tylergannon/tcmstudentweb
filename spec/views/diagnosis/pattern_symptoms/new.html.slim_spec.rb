require 'spec_helper'

describe "diagnosis/pattern_symptoms/new" do
  before(:each) do
    assign(:diagnosis_pattern_symptom, stub_model(Diagnosis::PatternSymptom,
      :pattern => nil,
      :symptom => nil,
      :commentary => "MyString",
      :maybe => false,
      :key_symptom => false,
      :position => 1
    ).as_new_record)
  end

  it "renders new diagnosis_pattern_symptom form" do
    render

    assert_select "form[action=?][method=?]", diagnosis_pattern_symptoms_path, "post" do
      assert_select "input#diagnosis_pattern_symptom_pattern[name=?]", "diagnosis_pattern_symptom[pattern]"
      assert_select "input#diagnosis_pattern_symptom_symptom[name=?]", "diagnosis_pattern_symptom[symptom]"
      assert_select "input#diagnosis_pattern_symptom_commentary[name=?]", "diagnosis_pattern_symptom[commentary]"
      assert_select "input#diagnosis_pattern_symptom_maybe[name=?]", "diagnosis_pattern_symptom[maybe]"
      assert_select "input#diagnosis_pattern_symptom_key_symptom[name=?]", "diagnosis_pattern_symptom[key_symptom]"
      assert_select "input#diagnosis_pattern_symptom_position[name=?]", "diagnosis_pattern_symptom[position]"
    end
  end
end
