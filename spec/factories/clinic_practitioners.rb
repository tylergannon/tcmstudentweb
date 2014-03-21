# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |i|
    "cool#{i}@gmail.com"
  end
  factory :clinic_practitioner, :class => 'Clinic::Practitioner', aliases: [:practitioner] do
    email
    password "nicebasdf#@$#"
  end
end
