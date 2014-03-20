require 'spec_helper'

describe "acupuncture/points/show" do
  before(:each) do
    @acupuncture_point = assign(:acupuncture_point, stub_model(Acupuncture::Point,
      :channel => nil,
      :orginal => 1,
      :pinyin => "Pinyin",
      :chinese => "Chinese",
      :name_discussion => "Name Discussion",
      :commentary => "Commentary",
      :canonical => "Canonical",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Pinyin/)
    expect(rendered).to match(/Chinese/)
    expect(rendered).to match(/Name Discussion/)
    expect(rendered).to match(/Commentary/)
    expect(rendered).to match(/Canonical/)
    expect(rendered).to match(/Slug/)
  end
end
