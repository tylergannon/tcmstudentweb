require 'spec_helper'

describe "diagnosis/pattern_symptoms/show" do
  before(:each) do
    @diagnosis_pattern_symptom = assign(:diagnosis_pattern_symptom, stub_model(Diagnosis::PatternSymptom,
      :pattern => nil,
      :symptom => nil,
      :commentary => "Commentary",
      :maybe => false,
      :key_symptom => false,
      :position => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Commentary/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
  end
end
