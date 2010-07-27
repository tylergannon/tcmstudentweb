class AcuPointInfo < ActiveRecord::Base
  has_many :acu_point_therapeutic_functions, :autosave => true
  has_many :therapeutic_functions, :through => :acu_point_therapeutic_functions
  has_many :acu_point_symptoms, :autosave => true
  has_many :symptoms, :through => :acu_point_symptoms
  belongs_to :acu_point
  validates_length_of :location, :maximum=>255

  def all_symptoms
    (symptoms + acu_point_therapeutic_functions.map_to(:symptoms)).flatten.uniq
  end

  acts_as_cited

  association_text :acu_point_symptoms, :name=>:symptom_name,
    :commentary=>:commentary, :scope=>:with_symptom_name

  association_text :acu_point_therapeutic_functions,
    :name=>:therapeutic_function_name,
    :commentary=>:commentary,
    :scope=>:with_tf_name

end

