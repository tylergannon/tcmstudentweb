require 'spec_helper'

describe "patterns/show" do
  before(:each) do
    @pattern = assign(:pattern, stub_model(Pattern,
      :name => "Name",
      :commentary => "Commentary",
      :citation_id => "Citation",
      :tongue => "Tongue",
      :pulse => "Pulse",
      :slug => "Slug",
      :canonical => "Canonical"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Commentary/)
    expect(rendered).to match(/Citation/)
    expect(rendered).to match(/Tongue/)
    expect(rendered).to match(/Pulse/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/Canonical/)
  end
end
