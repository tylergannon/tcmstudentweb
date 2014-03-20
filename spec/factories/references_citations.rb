# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :references_citation, :class => 'References::Citation' do
    source_id 1
    location "MyString"
  end
end
