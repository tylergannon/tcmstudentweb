require 'spec_helper'

describe "references/textbooks/show" do
  before(:each) do
    @references_textbook = assign(:references_textbook, stub_model(References::Textbook,
      :author => nil,
      :title => "Title",
      :slug => "Slug",
      :year => "Year",
      :abbreviation => "Abbreviation"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/Year/)
    expect(rendered).to match(/Abbreviation/)
  end
end
