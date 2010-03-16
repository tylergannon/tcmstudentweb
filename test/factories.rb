Factory.define :formula do |f|
  f.pinyin        "Gui Zhi tang"
  f.english       "Cinnamon twig decoction"
  f.association   :formula_category, :factory => :formula_category
  f.formula_herbs []
  f.formula_dui_yaos []
end

Factory.define :user do |f|
  f.login                   "tyler"
  f.email                   "tgannon@gmail.com"
  f.password                "tylerrules"
  f.password_confirmation   "tylerrules"
  f.persistence_token       Authlogic::Random.hex_token
  f.password_salt           salt = Authlogic::Random.hex_token
  f.single_access_token     Authlogic::Random.friendly_token
  f.perishable_token        Authlogic::Random.friendly_token
  f.crypted_password        Authlogic::CryptoProviders::Sha512.encrypt("tylerrules" + salt)
end

Factory.define :formula_category do |f|
  f.name          "Formulas that resolve the exterior"
end

Factory.define :contraindication do |f|
  f.name  "Spleen Qi deficiency diarrhea"
end
Factory.define :formula_category do |f|
  f.name  "Resolve Exterior"
end
Factory.define :channel do |f|
  f.name  "Lung"
  f.abbreviation  "Lu"
end

Factory.define :flavor do |f|
  f.name  "Sweet"
end

Factory.define :pattern do |f|
  f.name  "Liver Qi Stagnation"
end
Factory.define :pulse_quality do |f|
  f.name  "Rolling"
end

Factory.define :tongue_quality do |f|
  f.name  "Moist"
end
def therapeutic_functions
  ["Release the exterior", "Course the liver"]
end
def symptoms
  ["Headache", "Stomachache"]
end

Factory.define :acu_point do |f|
  f.sequence(:pinyin) {|n| "Zu #{n} li"}
  f.sequence(:english) {|n| "Leg #{n} miles"}
  f.association   :channel
  f.acu_point_therapeutic_functions do |aptf|
    therapeutic_functions.map{|tf| aptf.association(:acu_point_therapeutic_function, \
      :therapeutic_function => Factory(:therapeutic_function, :name => tf)
    )}
  end
  f.acu_point_symptoms do |aps|
    symptoms.map{|s|
      aps.association(:acu_point_symptom, \
        :symptom => Factory(:symptom, :name => s)
      )
    }
  end
#  f.association   :acu_point_therapeutic_functions, :count => 3, :factory => :acu_point_therapeutic_function
#  f.association   :acu_point_symptoms, :count => 3, :factory => :acu_point_symptom
  f.sequence(:ordinal) {|n| n}
end


Factory.define :formula_dui_yao do |f|
  f.association     :formula, :factory => :formula
  f.association     :dui_yao, :factory => :dui_yao
  f.commentary  "Herb 1 does stuff."
end

Factory.define :dui_yao do |f|
  f.association     :herb1,   :factory => :herb
  f.association     :herb2,   :factory => :herb
  f.commentary      "Foo Bar!!!"
end

Factory.define :herb do |f|
  f.sequence(:pinyin) {|n| "Gui Zhi #{n}"}
  f.sequence(:english) {|n| "Cinnamon Twig #{n}"}
  f.association     :herb_category, :factory => :herb_category
end

Factory.define :symptom do |f|
  f.sequence(:name) {|n| "Headache #{n}"}
end

Factory.define :therapeutic_function do |f|
  f.sequence(:name) {|n| "Release exterior #{n}"}
end

Factory.define :herb_category do |f|
  f.name            "Herbs that Resolve the Exterior"
end


Factory.define :acu_point_therapeutic_function do |f|
  f.association       :therapeutic_function, :factory => :therapeutic_function
  f.commentary        "This mostly works in combination with another point."
end

Factory.define :acu_point_symptom do |f|
  f.association       :symptom, :factory => :symptom
end

Factory.define :pattern_treatment_principle do |f|
  f.association       :treatment_principle, :factory => :therapeutic_function
end

Factory.define :pattern_symptom do |f|
  f.association       :symptom
  f.maybe             false
  f.key_symptom       true
  f.commentary        "What a bummer."
end

def create_pattern_symptom(name, commentary = "")
  Factory.create(:pattern_symptom, :commentary => commentary, :symptom => Factory(:symptom, :name => name))
end
def build_pattern_symptom(name, commentary = "")
  Factory.build(:pattern_symptom, :commentary => commentary, :symptom => Factory(:symptom, :name => name))
end


Factory.define :pattern do |f|
  f.name            "Liver Qi Stagnation"

    f.pattern_treatment_principles do |ptp|
    therapeutic_functions.map{|tf| ptp.association(:pattern_treatment_principle, \
      :treatment_principle => Factory(:therapeutic_function, :name => tf)
    )}
  end
  f.pattern_symptoms do |ps|
    symptoms.map{|tf|
      ps.association(:pattern_symptom, \
        :symptom => Factory(:symptom, :name => tf)
      )
    }
  end
end

Factory.define :citation do |c|
  c.where "p. 116"
  c.association(:textbook)
end

Factory.define :textbook do |t|
  t.title  'My Book'
  t.association(:author)
end

Factory.define :author do |a|
  a.name "Steve Woodley"
end