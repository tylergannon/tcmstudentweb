class HerbChannel < ActiveRecord::Base
	belongs_to :herb
	belongs_to :channel

	def channel_name=(name)
		self.channel = Channel.find_or_create_by_name(name) unless name.blank?
	end
	
	def channel_name
		channel.name if channel
	end
	
end
