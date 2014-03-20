require 'spec_helper'

describe "patterns/new" do
  before(:each) do
    assign(:pattern, stub_model(Pattern,
      :name => "MyString",
      :commentary => "MyString",
      :citation_id => "MyString",
      :tongue => "MyString",
      :pulse => "MyString",
      :slug => "MyString",
      :canonical => "MyString"
    ).as_new_record)
  end

  it "renders new pattern form" do
    render

    assert_select "form[action=?][method=?]", patterns_path, "post" do
      assert_select "input#pattern_name[name=?]", "pattern[name]"
      assert_select "input#pattern_commentary[name=?]", "pattern[commentary]"
      assert_select "input#pattern_citation_id[name=?]", "pattern[citation_id]"
      assert_select "input#pattern_tongue[name=?]", "pattern[tongue]"
      assert_select "input#pattern_pulse[name=?]", "pattern[pulse]"
      assert_select "input#pattern_slug[name=?]", "pattern[slug]"
      assert_select "input#pattern_canonical[name=?]", "pattern[canonical]"
    end
  end
end
