class FormulaPulseQuality < ActiveRecord::Base
	belongs_to :formula
	belongs_to :pulse_quality
	
	def pulse_quality_name=(name)
		self.pulse_quality = PulseQuality.find_or_create_by_name(name) unless name.blank?
	end
	
	def pulse_quality_name
		pulse_quality.name if pulse_quality
	end
	
end
