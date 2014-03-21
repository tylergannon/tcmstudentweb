require 'spec_helper'

describe "clinic/patients/edit" do
  before(:each) do
    @clinic_patient = assign(:clinic_patient, stub_model(Clinic::Patient,
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit clinic_patient form" do
    render

    assert_select "form[action=?][method=?]", clinic_patient_path(@clinic_patient), "post" do
      assert_select "input#clinic_patient_name[name=?]", "clinic_patient[name]"
      assert_select "input#clinic_patient_slug[name=?]", "clinic_patient[slug]"
    end
  end
end
