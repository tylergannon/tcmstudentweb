require 'spec_helper'

describe "references/citations/index" do
  before(:each) do
    assign(:references_citations, [
      stub_model(References::Citation,
        :source_id => 1,
        :location => "Location"
      ),
      stub_model(References::Citation,
        :source_id => 1,
        :location => "Location"
      )
    ])
  end

  it "renders a list of references/citations" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
