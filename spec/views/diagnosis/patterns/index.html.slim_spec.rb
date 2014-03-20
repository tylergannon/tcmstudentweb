require 'spec_helper'

describe "diagnosis/patterns/index" do
  before(:each) do
    assign(:diagnosis_patterns, [
      stub_model(Diagnosis::Pattern,
        :name => "Name",
        :commentary => "Commentary",
        :citation_id => "Citation",
        :tongue => "Tongue",
        :pulse => "Pulse",
        :slug => "Slug",
        :canonical => "Canonical"
      ),
      stub_model(Diagnosis::Pattern,
        :name => "Name",
        :commentary => "Commentary",
        :citation_id => "Citation",
        :tongue => "Tongue",
        :pulse => "Pulse",
        :slug => "Slug",
        :canonical => "Canonical"
      )
    ])
  end

  it "renders a list of diagnosis/patterns" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Commentary".to_s, :count => 2
    assert_select "tr>td", :text => "Citation".to_s, :count => 2
    assert_select "tr>td", :text => "Tongue".to_s, :count => 2
    assert_select "tr>td", :text => "Pulse".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Canonical".to_s, :count => 2
  end
end
