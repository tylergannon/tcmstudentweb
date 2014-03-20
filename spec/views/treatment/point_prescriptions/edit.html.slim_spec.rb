require 'spec_helper'

describe "treatment/point_prescriptions/edit" do
  before(:each) do
    @treatment_point_prescription = assign(:treatment_point_prescription, stub_model(Treatment::PointPrescription,
      :name => "MyString",
      :slug => "MyString",
      :commentary => "MyString",
      :citation => nil,
      :pattern => nil
    ))
  end

  it "renders the edit treatment_point_prescription form" do
    render

    assert_select "form[action=?][method=?]", treatment_point_prescription_path(@treatment_point_prescription), "post" do
      assert_select "input#treatment_point_prescription_name[name=?]", "treatment_point_prescription[name]"
      assert_select "input#treatment_point_prescription_slug[name=?]", "treatment_point_prescription[slug]"
      assert_select "input#treatment_point_prescription_commentary[name=?]", "treatment_point_prescription[commentary]"
      assert_select "input#treatment_point_prescription_citation[name=?]", "treatment_point_prescription[citation]"
      assert_select "input#treatment_point_prescription_pattern[name=?]", "treatment_point_prescription[pattern]"
    end
  end
end
