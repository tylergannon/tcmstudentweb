# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :references_textbook, :class => 'References::Textbook' do
    author nil
    title "MyString"
    slug "MyString"
    year "MyString"
    abbreviation "MyString"
  end
end
