require 'spec_helper'

describe "references/textbooks/edit" do
  before(:each) do
    @references_textbook = assign(:references_textbook, stub_model(References::Textbook,
      :author => nil,
      :title => "MyString",
      :slug => "MyString",
      :year => "MyString",
      :abbreviation => "MyString"
    ))
  end

  it "renders the edit references_textbook form" do
    render

    assert_select "form[action=?][method=?]", references_textbook_path(@references_textbook), "post" do
      assert_select "input#references_textbook_author[name=?]", "references_textbook[author]"
      assert_select "input#references_textbook_title[name=?]", "references_textbook[title]"
      assert_select "input#references_textbook_slug[name=?]", "references_textbook[slug]"
      assert_select "input#references_textbook_year[name=?]", "references_textbook[year]"
      assert_select "input#references_textbook_abbreviation[name=?]", "references_textbook[abbreviation]"
    end
  end
end
