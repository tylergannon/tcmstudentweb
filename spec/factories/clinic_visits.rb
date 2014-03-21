# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clinic_visit, :class => 'Clinic::Visit' do
    patient nil
    appointment_time "2014-03-21 21:21:48"
  end
end
