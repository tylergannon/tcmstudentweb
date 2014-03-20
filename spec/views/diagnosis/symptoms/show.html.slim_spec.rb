require 'spec_helper'

describe "diagnosis/symptoms/show" do
  before(:each) do
    @diagnosis_symptom = assign(:diagnosis_symptom, stub_model(Diagnosis::Symptom,
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
