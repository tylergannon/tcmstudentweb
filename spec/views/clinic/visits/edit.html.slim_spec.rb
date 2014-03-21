require 'spec_helper'

describe "clinic/visits/edit" do
  before(:each) do
    @clinic_visit = assign(:clinic_visit, stub_model(Clinic::Visit,
      :patient => nil
    ))
  end

  it "renders the edit clinic_visit form" do
    render

    assert_select "form[action=?][method=?]", clinic_visit_path(@clinic_visit), "post" do
      assert_select "input#clinic_visit_patient[name=?]", "clinic_visit[patient]"
    end
  end
end
