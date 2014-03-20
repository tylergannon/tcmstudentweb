require 'spec_helper'

describe "diagnosis/symptoms/index" do
  before(:each) do
    assign(:diagnosis_symptoms, [
      stub_model(Diagnosis::Symptom,
        :name => "Name",
        :slug => "Slug"
      ),
      stub_model(Diagnosis::Symptom,
        :name => "Name",
        :slug => "Slug"
      )
    ])
  end

  it "renders a list of diagnosis/symptoms" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
  end
end
