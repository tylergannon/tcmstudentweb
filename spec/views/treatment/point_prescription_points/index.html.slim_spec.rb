require 'spec_helper'

describe "treatment/point_prescription_points/index" do
  before(:each) do
    assign(:treatment_point_prescription_points, [
      stub_model(Treatment::PointPrescriptionPoint,
        :point_prescription_id => 1,
        :point_id => 2,
        :reason => "Reason",
        :commentary => "Commentary"
      ),
      stub_model(Treatment::PointPrescriptionPoint,
        :point_prescription_id => 1,
        :point_id => 2,
        :reason => "Reason",
        :commentary => "Commentary"
      )
    ])
  end

  it "renders a list of treatment/point_prescription_points" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Reason".to_s, :count => 2
    assert_select "tr>td", :text => "Commentary".to_s, :count => 2
  end
end
