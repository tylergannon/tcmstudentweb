require 'spec_helper'

describe "acupuncture/points/new" do
  before(:each) do
    assign(:acupuncture_point, stub_model(Acupuncture::Point,
      :channel => nil,
      :position => 1,
      :pinyin => "MyString",
      :chinese => "MyString",
      :name_discussion => "MyString",
      :commentary => "MyString",
      :canonical => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new acupuncture_point form" do
    render

    assert_select "form[action=?][method=?]", acupuncture_points_path, "post" do
      assert_select "input#acupuncture_point_channel[name=?]", "acupuncture_point[channel]"
      assert_select "input#acupuncture_point_position[name=?]", "acupuncture_point[position]"
      assert_select "input#acupuncture_point_pinyin[name=?]", "acupuncture_point[pinyin]"
      assert_select "input#acupuncture_point_chinese[name=?]", "acupuncture_point[chinese]"
      assert_select "input#acupuncture_point_name_discussion[name=?]", "acupuncture_point[name_discussion]"
      assert_select "input#acupuncture_point_commentary[name=?]", "acupuncture_point[commentary]"
      assert_select "input#acupuncture_point_canonical[name=?]", "acupuncture_point[canonical]"
      assert_select "input#acupuncture_point_slug[name=?]", "acupuncture_point[slug]"
    end
  end
end
