require 'spec_helper'

describe "references/citations/show" do
  before(:each) do
    @references_citation = assign(:references_citation, stub_model(References::Citation,
      :source_id => 1,
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Location/)
  end
end
