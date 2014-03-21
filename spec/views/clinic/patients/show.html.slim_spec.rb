require 'spec_helper'

describe "clinic/patients/show" do
  before(:each) do
    @clinic_patient = assign(:clinic_patient, stub_model(Clinic::Patient,
      :name => "Name",
      :slug => "Slug"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Slug/)
  end
end
