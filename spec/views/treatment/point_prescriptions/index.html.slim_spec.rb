require 'spec_helper'

describe "treatment/point_prescriptions/index" do
  before(:each) do
    assign(:treatment_point_prescriptions, [
      stub_model(Treatment::PointPrescription,
        :name => "Name",
        :slug => "Slug",
        :commentary => "Commentary",
        :citation_id => 1.to_s,
        :pattern_id => 2
      ),
      stub_model(Treatment::PointPrescription,
        :name => "Name",
        :slug => "Slug",
        :commentary => "Commentary",
        :citation_id => 1,
        :pattern_id => 2
      )
    ])
  end

  it "renders a list of treatment/point_prescriptions" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Commentary".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2, :count => 2
  end
end
