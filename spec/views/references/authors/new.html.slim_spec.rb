require 'spec_helper'

describe "references/authors/new" do
  before(:each) do
    assign(:references_author, stub_model(References::Author,
      :name => "MyString",
      :slug => "MyString"
    ).as_new_record)
  end

  it "renders new references_author form" do
    render

    assert_select "form[action=?][method=?]", references_authors_path, "post" do
      assert_select "input#references_author_name[name=?]", "references_author[name]"
      assert_select "input#references_author_slug[name=?]", "references_author[slug]"
    end
  end
end
