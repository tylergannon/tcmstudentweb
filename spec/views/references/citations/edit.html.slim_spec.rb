require 'spec_helper'

describe "references/citations/edit" do
  before(:each) do
    @references_citation = assign(:references_citation, stub_model(References::Citation,
      :source_id => 1,
      :location => "MyString"
    ))
  end

  it "renders the edit references_citation form" do
    render

    assert_select "form[action=?][method=?]", references_citation_path(@references_citation), "post" do
      assert_select "input#references_citation_source_id[name=?]", "references_citation[source_id]"
      assert_select "input#references_citation_location[name=?]", "references_citation[location]"
    end
  end
end
