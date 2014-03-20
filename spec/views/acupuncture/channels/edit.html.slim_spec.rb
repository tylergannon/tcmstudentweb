require 'spec_helper'

describe "acupuncture/channels/edit" do
  before(:each) do
    @acupuncture_channel = assign(:acupuncture_channel, stub_model(Acupuncture::Channel,
      :name => "MyString",
      :abbreviation => "MyString"
    ))
  end

  it "renders the edit acupuncture_channel form" do
    render

    assert_select "form[action=?][method=?]", acupuncture_channel_path(@acupuncture_channel), "post" do
      assert_select "input#acupuncture_channel_name[name=?]", "acupuncture_channel[name]"
      assert_select "input#acupuncture_channel_abbreviation[name=?]", "acupuncture_channel[abbreviation]"
    end
  end
end
