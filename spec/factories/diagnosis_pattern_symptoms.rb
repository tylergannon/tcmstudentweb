# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :diagnosis_pattern_symptom, :class => 'Diagnosis::PatternSymptom' do
    pattern nil
    symptom nil
    commentary "MyString"
    maybe false
    key_symptom false
    position 1
  end
end
