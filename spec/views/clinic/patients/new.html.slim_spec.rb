require 'spec_helper'

describe "clinic/patients/new" do
  before(:each) do
    assign(:clinic_patient, stub_model(Clinic::Patient,
      :name => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new clinic_patient form" do
    render

    assert_select "form[action=?][method=?]", clinic_patients_path, "post" do
      assert_select "input#clinic_patient_name[name=?]", "clinic_patient[name]"
      assert_select "input#clinic_patient_slug[name=?]", "clinic_patient[slug]"
    end
  end
end
