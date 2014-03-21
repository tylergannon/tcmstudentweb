class Acupuncture::Point < ActiveRecord::Base
  extend FriendlyId

  belongs_to :channel, class: Acupuncture::Channel
  friendly_id :name, use: :slugged
  
  def name
    channel.abbreviation + "-" + position.to_s + " " + pinyin
  end
end
