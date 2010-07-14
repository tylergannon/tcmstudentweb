class AcuPointTherapeuticFunction < ActiveRecord::Base
  belongs_to :acu_point_info
  belongs_to :therapeutic_function
  acts_as_linkable :name => :therapeutic_function_name
	named_association :therapeutic_function, :name, :create => true
	has_and_belongs_to_many :symptoms, :autosave=>true

	after_save :scan_commentary

	def scan_commentary
	  return unless commentary
	  match = commentary.match(/"s:\[([\w\s\:\-\,]+)\]"/m)

    str = match ? match[1] : ""
    strs = str.split(",").strip_each
    self.symptoms = strs.map{|s|
      symptom = Symptom.named(s)
      symptom ||= Symptom.create(:name=>s)
    }

    match = commentary.match(/tags:\s*([\w \-\,]+)/m)
    set_tf_tags(match[1]) if match
  end

	def set_tf_tags(tag_list)
	  self.therapeutic_function.tag_list = tag_list if therapeutic_function
	  self.therapeutic_function.save if therapeutic_function
  end

	scope :with_tf_name, lambda{|name|
	  tf = TherapeuticFunction.named(name)
	  id = tf.id if tf
	  joins(:therapeutic_function).where(
	    :therapeutic_functions=>{:id=>id})
  }

end

