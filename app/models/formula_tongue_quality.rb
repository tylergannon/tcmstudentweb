class FormulaTongueQuality < ActiveRecord::Base
	belongs_to :formula
	belongs_to :tongue_quality
	
	def tongue_quality_name=(name)
		self.tongue_quality = TongueQuality.find_or_create_by_name(name) unless name.blank?
	end
	
	def tongue_quality_name
		tongue_quality.name if tongue_quality
	end
end
