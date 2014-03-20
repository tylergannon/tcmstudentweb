# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :acupuncture_point, :class => 'Acupuncture::Point' do
    channel
    position 1
    pinyin "MyString"
    chinese "MyString"
    name_discussion "MyString"
    commentary "MyString"
    canonical "MyString"
    slug "MyString"
  end
end
