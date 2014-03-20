# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diagnosis_symptom, :class => 'Diagnosis::Symptom' do
    name "MyString"
    slug "MyString"
  end
end
