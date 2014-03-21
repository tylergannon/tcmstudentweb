class Clinic::Patient < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  belongs_to :practitioner, class: Clinic::Practitioner, foreign_key: 'practitioner_id'
  validates :practitioner, presence: true
  
  has_many :visits
end
