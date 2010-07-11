class TherapeuticFunction < ActiveRecord::Base
	has_many :herb_therapeutic_functions
	has_many :herbs, :through => :herb_therapeutic_functions
  has_many :formula_therapeutic_functions
  has_many :formulas, :through => :formula_therapeutic_functions
  has_many :acu_point_therapeutic_functions
  has_many :acu_point_infos, :through => :acu_point_therapeutic_functions
#  has_many :acu_points, :through => :acu_point_infos
  acts_as_taggable
  
  scope :join_acu_point, joins([{:acu_point_therapeutic_functions=>{:acu_point_info=>:acu_point}}])

  scope :by_channel, lambda {|channel_id|
    join_acu_point.where(:acu_points=>{:channel_id=>channel_id})
  }

  acts_as_linkable :name=>:name

  def consolidate(tf)
    tf.herb_therapeutic_functions.each { |htf| herb_therapeutic_functions << htf }
    tf.acu_point_therapeutic_functions.each { |htf| acu_point_therapeutic_functions << htf }
    tf.formula_therapeutic_functions.each { |htf| formula_therapeutic_functions << htf }
    tf.destroy    
  end

  def acu_points
    acu_point_infos.map{|a| a.acu_point}
  end
  
  search_on :name
  scope :search_mod, order("char_length(name)")
end
