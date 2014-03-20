require 'spec_helper'

describe "treatment/point_prescriptions/new" do
  before(:each) do
    assign(:treatment_point_prescription, stub_model(Treatment::PointPrescription,
      :name => "MyString",
      :slug => "MyString",
      :commentary => "MyString",
      :citation => nil,
      :pattern => nil
    ).as_new_record)
  end

  it "renders new treatment_point_prescription form" do
    render

    assert_select "form[action=?][method=?]", treatment_point_prescriptions_path, "post" do
      assert_select "input#treatment_point_prescription_name[name=?]", "treatment_point_prescription[name]"
      assert_select "input#treatment_point_prescription_slug[name=?]", "treatment_point_prescription[slug]"
      assert_select "input#treatment_point_prescription_commentary[name=?]", "treatment_point_prescription[commentary]"
      assert_select "input#treatment_point_prescription_citation[name=?]", "treatment_point_prescription[citation]"
      assert_select "input#treatment_point_prescription_pattern[name=?]", "treatment_point_prescription[pattern]"
    end
  end
end
