require 'spec_helper'

describe "acupuncture/channels/show" do
  before(:each) do
    @acupuncture_channel = assign(:acupuncture_channel, stub_model(Acupuncture::Channel,
      :name => "Name",
      :abbreviation => "Abbreviation"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Abbreviation/)
  end
end
