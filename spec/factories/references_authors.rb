# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :references_author, :class => 'References::Author' do
    name "MyString"
    slug "MyString"
  end
end
