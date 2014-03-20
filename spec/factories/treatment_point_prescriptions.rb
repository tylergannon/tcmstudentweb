# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :treatment_point_prescription, :class => 'Treatment::PointPrescription' do
    name "MyString"
    slug "MyString"
    commentary "MyString"
    citation nil
    pattern nil
  end
end
