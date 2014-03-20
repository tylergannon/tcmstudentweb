require 'spec_helper'

describe "treatment/point_prescription_points/show" do
  before(:each) do
    @treatment_point_prescription_point = assign(:treatment_point_prescription_point, stub_model(Treatment::PointPrescriptionPoint,
      :point_prescription => nil,
      :point => nil,
      :reason => "Reason",
      :commentary => "Commentary"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Reason/)
    expect(rendered).to match(/Commentary/)
  end
end
