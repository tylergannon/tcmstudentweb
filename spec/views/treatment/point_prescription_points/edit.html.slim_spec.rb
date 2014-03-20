require 'spec_helper'

describe "treatment/point_prescription_points/edit" do
  before(:each) do
    @treatment_point_prescription_point = assign(:treatment_point_prescription_point, stub_model(Treatment::PointPrescriptionPoint,
      :point_prescription => nil,
      :point => nil,
      :reason => "MyString",
      :commentary => "MyString"
    ))
  end

  it "renders the edit treatment_point_prescription_point form" do
    render

    assert_select "form[action=?][method=?]", treatment_point_prescription_point_path(@treatment_point_prescription_point), "post" do
      assert_select "input#treatment_point_prescription_point_point_prescription[name=?]", "treatment_point_prescription_point[point_prescription]"
      assert_select "input#treatment_point_prescription_point_point[name=?]", "treatment_point_prescription_point[point]"
      assert_select "input#treatment_point_prescription_point_reason[name=?]", "treatment_point_prescription_point[reason]"
      assert_select "input#treatment_point_prescription_point_commentary[name=?]", "treatment_point_prescription_point[commentary]"
    end
  end
end
