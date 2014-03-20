require 'spec_helper'

describe "references/authors/index" do
  before(:each) do
    assign(:references_authors, [
      stub_model(References::Author,
        :name => "Name",
        :slug => "Slug"
      ),
      stub_model(References::Author,
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of references/authors" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
