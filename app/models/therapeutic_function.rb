class TherapeuticFunction < ActiveRecord::Base
	has_many :herb_therapeutic_functions
	has_many :herbs, :through => :herb_therapeutic_functions
  has_many :formula_therapeutic_functions
  has_many :formulas, :through => :formula_therapeutic_functions
  has_many :acu_point_therapeutic_functions
  has_many :acu_point_infos, :through => :acu_point_therapeutic_functions
#  has_many :acu_points, :through => :acu_point_infos

  def acu_points
    acu_point_infos.map{|a| a.acu_point}
  end

  default_scope :order => 'name'
  def self.search_columns
    ["name"]
  end
end
