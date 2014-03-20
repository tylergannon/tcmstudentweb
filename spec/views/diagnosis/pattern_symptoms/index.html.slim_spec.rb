require 'spec_helper'

describe "diagnosis/pattern_symptoms/index" do
  before(:each) do
    assign(:diagnosis_pattern_symptoms, [
      stub_model(Diagnosis::PatternSymptom,
        :pattern_id => 1,
        :symptom_id => 2,
        :commentary => "Commentary",
        :maybe => false,
        :key_symptom => false,
        :position => 1
      ),
      stub_model(Diagnosis::PatternSymptom,
        :pattern_id => 1,
        :symptom_id => 2,
        :commentary => "Commentary",
        :maybe => false,
        :key_symptom => false,
        :position => 1
      )
    ])
  end

  pending "renders a list of diagnosis/pattern_symptoms" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Commentary".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
