require 'spec_helper'

describe "acupuncture/channels/index" do
  before(:each) do
    assign(:acupuncture_channels, [
      stub_model(Acupuncture::Channel,
        :name => "Name",
        :abbreviation => "Abbreviation"
      ),
      stub_model(Acupuncture::Channel,
        :name => "Name",
        :abbreviation => "Abbreviation"
      )
    ])
  end

  it "renders a list of acupuncture/channels" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Abbreviation".to_s, :count => 2
  end
end
