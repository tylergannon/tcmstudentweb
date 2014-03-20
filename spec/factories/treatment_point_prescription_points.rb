# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :treatment_point_prescription_point, :class => 'Treatment::PointPrescriptionPoint' do
    point_prescription nil
    point nil
    reason "MyString"
    commentary "MyString"
  end
end
