require 'spec_helper'

describe "acupuncture/channels/new" do
  before(:each) do
    assign(:acupuncture_channel, stub_model(Acupuncture::Channel,
      :name => "MyString",
      :abbreviation => "MyString"
    ).as_new_record)
  end

  it "renders new acupuncture_channel form" do
    render

    assert_select "form[action=?][method=?]", acupuncture_channels_path, "post" do
      assert_select "input#acupuncture_channel_name[name=?]", "acupuncture_channel[name]"
      assert_select "input#acupuncture_channel_abbreviation[name=?]", "acupuncture_channel[abbreviation]"
    end
  end
end
