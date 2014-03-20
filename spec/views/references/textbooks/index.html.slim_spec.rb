require 'spec_helper'

describe "references/textbooks/index" do
  before(:each) do
    assign(:references_textbooks, [
      stub_model(References::Textbook,
        :author => nil,
        :title => "Title",
        :slug => "Slug",
        :year => "Year",
        :abbreviation => "Abbreviation"
      ),
      stub_model(References::Textbook,
        :author => nil,
        :title => "Title",
        :slug => "Slug",
        :year => "Year",
        :abbreviation => "Abbreviation"
      )
    ])
  end

  it "renders a list of references/textbooks" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Year".to_s, :count => 2
    assert_select "tr>td", :text => "Abbreviation".to_s, :count => 2
  end
end
