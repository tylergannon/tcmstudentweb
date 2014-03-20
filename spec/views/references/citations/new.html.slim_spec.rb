require 'spec_helper'

describe "references/citations/new" do
  before(:each) do
    assign(:references_citation, stub_model(References::Citation,
      :source_id => 1,
      :location => "MyString"
    ).as_new_record)
  end

  it "renders new references_citation form" do
    render

    assert_select "form[action=?][method=?]", references_citations_path, "post" do
      assert_select "input#references_citation_source_id[name=?]", "references_citation[source_id]"
      assert_select "input#references_citation_location[name=?]", "references_citation[location]"
    end
  end
end
