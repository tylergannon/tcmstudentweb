require 'spec_helper'

describe "diagnosis/patterns/new" do
  before(:each) do
    assign(:diagnosis_pattern, stub_model(Diagnosis::Pattern,
      :name => "MyString",
      :commentary => "MyString",
      :citation_id => "MyString",
      :tongue => "MyString",
      :pulse => "MyString",
      :slug => "MyString",
      :canonical => "MyString"
    ).as_new_record)
  end

  it "renders new diagnosis_pattern form" do
    render

    assert_select "form[action=?][method=?]", diagnosis_patterns_path, "post" do
      assert_select "input#diagnosis_pattern_name[name=?]", "diagnosis_pattern[name]"
      assert_select "input#diagnosis_pattern_commentary[name=?]", "diagnosis_pattern[commentary]"
      assert_select "input#diagnosis_pattern_citation_id[name=?]", "diagnosis_pattern[citation_id]"
      assert_select "input#diagnosis_pattern_tongue[name=?]", "diagnosis_pattern[tongue]"
      assert_select "input#diagnosis_pattern_pulse[name=?]", "diagnosis_pattern[pulse]"
      assert_select "input#diagnosis_pattern_slug[name=?]", "diagnosis_pattern[slug]"
      assert_select "input#diagnosis_pattern_canonical[name=?]", "diagnosis_pattern[canonical]"
    end
  end
end
