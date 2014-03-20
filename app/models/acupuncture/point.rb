class Acupuncture::Point < ActiveRecord::Base
  belongs_to :channel, class: 'Acupuncture::Channel'
end
