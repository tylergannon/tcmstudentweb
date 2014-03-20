class Acupuncture::Point < ActiveRecord::Base
  extend FriendlyId

  belongs_to :channel, class: Acupuncture::Channel
  friendly_id :name, use: :slugged
end
