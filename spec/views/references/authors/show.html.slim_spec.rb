require 'spec_helper'

describe "references/authors/show" do
  before(:each) do
    @references_author = assign(:references_author, stub_model(References::Author,
      :name => "Name",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
  end
end
