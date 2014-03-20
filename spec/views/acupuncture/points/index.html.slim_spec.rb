require 'spec_helper'

describe "acupuncture/points/index" do
  before(:each) do
    assign(:acupuncture_points, [
      stub_model(Acupuncture::Point,
        :channel => nil,
        :position => 1,
        :pinyin => "Pinyin",
        :chinese => "Chinese",
        :name_discussion => "Name Discussion",
        :commentary => "Commentary",
        :canonical => "Canonical",
        :slug => "Slug"
      ),
      stub_model(Acupuncture::Point,
        :channel => nil,
        :position => 1,
        :pinyin => "Pinyin",
        :chinese => "Chinese",
        :name_discussion => "Name Discussion",
        :commentary => "Commentary",
        :canonical => "Canonical",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of acupuncture/points" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Pinyin".to_s, :count => 2
    assert_select "tr>td", :text => "Chinese".to_s, :count => 2
    assert_select "tr>td", :text => "Name Discussion".to_s, :count => 2
    assert_select "tr>td", :text => "Commentary".to_s, :count => 2
    assert_select "tr>td", :text => "Canonical".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
