require 'spec_helper'

describe "diagnosis/symptoms/new" do
  before(:each) do
    assign(:diagnosis_symptom, stub_model(Diagnosis::Symptom,
      :name => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new diagnosis_symptom form" do
    render

    assert_select "form[action=?][method=?]", diagnosis_symptoms_path, "post" do
      assert_select "input#diagnosis_symptom_name[name=?]", "diagnosis_symptom[name]"
      assert_select "input#diagnosis_symptom_slug[name=?]", "diagnosis_symptom[slug]"
    end
  end
end
