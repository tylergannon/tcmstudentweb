require 'spec_helper'

describe "references/authors/edit" do
  before(:each) do
    @references_author = assign(:references_author, stub_model(References::Author,
      :name => "MyString",
      :slug => "MyString"
    ))
  end

  it "renders the edit references_author form" do
    render

    assert_select "form[action=?][method=?]", references_author_path(@references_author), "post" do
      assert_select "input#references_author_name[name=?]", "references_author[name]"
      assert_select "input#references_author_slug[name=?]", "references_author[slug]"
    end
  end
end
