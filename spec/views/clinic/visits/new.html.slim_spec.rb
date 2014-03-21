require 'spec_helper'

describe "clinic/visits/new" do
  before(:each) do
    assign(:clinic_visit, stub_model(Clinic::Visit,
      :patient => nil
    ).as_new_record)
  end

  it "renders new clinic_visit form" do
    render

    assert_select "form[action=?][method=?]", clinic_visits_path, "post" do
      assert_select "input#clinic_visit_patient[name=?]", "clinic_visit[patient]"
    end
  end
end
