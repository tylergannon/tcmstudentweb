require 'spec_helper'

describe "diagnosis/patterns/show" do
  before(:each) do
    @diagnosis_pattern = assign(:diagnosis_pattern, stub_model(Diagnosis::Pattern,
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
