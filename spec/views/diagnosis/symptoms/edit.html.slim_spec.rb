require 'spec_helper'

describe "diagnosis/symptoms/edit" do
  before(:each) do
    @diagnosis_symptom = assign(:diagnosis_symptom, stub_model(Diagnosis::Symptom,
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit diagnosis_symptom form" do
    render

    assert_select "form[action=?][method=?]", diagnosis_symptom_path(@diagnosis_symptom), "post" do
      assert_select "input#diagnosis_symptom_name[name=?]", "diagnosis_symptom[name]"
      assert_select "input#diagnosis_symptom_slug[name=?]", "diagnosis_symptom[slug]"
    end
  end
end
