require 'spec_helper'

describe "treatment/point_prescription_points/new" do
  before(:each) do
    assign(:treatment_point_prescription_point, stub_model(Treatment::PointPrescriptionPoint,
      :point_prescription => nil,
      :point => nil,
      :reason => "MyString",
      :commentary => "MyString"
    ).as_new_record)
  end

  it "renders new treatment_point_prescription_point form" do
    render

    assert_select "form[action=?][method=?]", treatment_point_prescription_points_path, "post" do
      assert_select "input#treatment_point_prescription_point_point_prescription[name=?]", "treatment_point_prescription_point[point_prescription]"
      assert_select "input#treatment_point_prescription_point_point[name=?]", "treatment_point_prescription_point[point]"
      assert_select "input#treatment_point_prescription_point_reason[name=?]", "treatment_point_prescription_point[reason]"
      assert_select "input#treatment_point_prescription_point_commentary[name=?]", "treatment_point_prescription_point[commentary]"
    end
  end
end
