# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clinic_patient, :class => 'Clinic::Patient' do
    name "MyString"
    slug "MyString"
  end
end
