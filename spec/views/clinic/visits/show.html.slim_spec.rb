require 'spec_helper'

describe "clinic/visits/show" do
  before(:each) do
    @clinic_visit = assign(:clinic_visit, stub_model(Clinic::Visit,
      :patient => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
