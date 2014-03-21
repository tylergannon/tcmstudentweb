class Clinic::Visit < ActiveRecord::Base
  belongs_to :patient
  belongs_to :practitioner
  validates :patient, presence: true
  validates :practitioner, presence: true
  validates :appointment_time, presence: true
  
  def visit_id
    patient.name + " " + appointment_time.strftime('%Y-%m-%d %H:%M')
  end
  
  extend FriendlyId
  friendly_id :visit_id, use: :slugged
end
