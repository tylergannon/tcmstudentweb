class Clinic::Visit < ActiveRecord::Base
  belongs_to :patient
end
