# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diagnosis_pattern, :class => 'Diagnosis::Pattern' do
    name "MyString"
    commentary "MyString"
    citation_id "MyString"
    tongue "MyString"
    pulse "MyString"
    slug "MyString"
    canonical "MyString"
  end
end
