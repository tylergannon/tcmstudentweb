# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :clinic_visit, :class => 'Clinic::Visit' do
    patient
    appointment_time "2014-03-21 21:21:48"
    practitioner
  end
end
