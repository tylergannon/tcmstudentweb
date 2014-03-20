# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :acupuncture_channel, :class => 'Acupuncture::Channel' do
    name "MyString"
    abbreviation "MyString"
  end
end
