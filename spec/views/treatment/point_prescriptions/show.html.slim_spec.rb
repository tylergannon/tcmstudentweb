require 'spec_helper'

describe "treatment/point_prescriptions/show" do
  before(:each) do
    @treatment_point_prescription = assign(:treatment_point_prescription, stub_model(Treatment::PointPrescription,
      :name => "Name",
      :slug => "Slug",
      :commentary => "Commentary",
      :citation => nil,
      :pattern => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
    expect(rendered).to match(/Commentary/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
