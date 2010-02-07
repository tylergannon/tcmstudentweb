class Herb < ActiveRecord::Base
	
	has_many :herb_flavors
	has_many :herbs, :through => :herb_flavors
	accepts_nested_attributes_for :herb_flavors, :reject_if => proc {|a| a['flavor_name'.blank?]}

	belongs_to :herb_category
	accepts_nested_attributes_for :herb_category, :reject_if => proc {|a| a['name'.blank?]}

	has_many :herb_channels
	has_many :channels, :through => :herb_channels
	accepts_nested_attributes_for :herb_channels, :reject_if => proc {|a| a['channel_name'.blank?]}
	
	has_many :herb_therapeutic_functions
	has_many :therapeutic_functions, :through => :herb_therapeutic_functions
	accepts_nested_attributes_for :herb_therapeutic_functions, :reject_if => proc {|a| a['therapeutic_function_name'.blank?]}
	
	has_many :herb_comparisons, :foreign_key => :herb1_id
	accepts_nested_attributes_for :herb_comparisons, :reject_if => proc {|a| a['herb2_pinyin'.blank?]}
	
	has_many :other_herb_comparisons, :foreign_key => :herb2_id, :class_name => "HerbComparison"

	def display_name
	  latin ? "#{pinyin} #{latin}" : pinyin
	end
	
	def all_comparisons
		herb_comparisons + other_herb_comparisons	  
	end
	
	def herb_category_name=(name)
		self.herb_category = HerbCategory.find_or_create_by_name(name) unless name.blank?
	end
	
	def herb_category_name
		herb_category.name if herb_category
	end
end
