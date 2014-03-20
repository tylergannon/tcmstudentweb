require 'spec_helper'

describe "acupuncture/points/edit" do
  before(:each) do
    @acupuncture_point = assign(:acupuncture_point, stub_model(Acupuncture::Point,
      :channel => nil,
      :orginal => 1,
      :pinyin => "MyString",
      :chinese => "MyString",
      :name_discussion => "MyString",
      :commentary => "MyString",
      :canonical => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit acupuncture_point form" do
    render

    assert_select "form[action=?][method=?]", acupuncture_point_path(@acupuncture_point), "post" do
      assert_select "input#acupuncture_point_channel[name=?]", "acupuncture_point[channel]"
      assert_select "input#acupuncture_point_orginal[name=?]", "acupuncture_point[orginal]"
      assert_select "input#acupuncture_point_pinyin[name=?]", "acupuncture_point[pinyin]"
      assert_select "input#acupuncture_point_chinese[name=?]", "acupuncture_point[chinese]"
      assert_select "input#acupuncture_point_name_discussion[name=?]", "acupuncture_point[name_discussion]"
      assert_select "input#acupuncture_point_commentary[name=?]", "acupuncture_point[commentary]"
      assert_select "input#acupuncture_point_canonical[name=?]", "acupuncture_point[canonical]"
      assert_select "input#acupuncture_point_slug[name=?]", "acupuncture_point[slug]"
    end
  end
end
