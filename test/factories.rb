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

Factory.define :acu_point do |f|
  f.sequence(:pinyin) {|n| "Zu #{n} li"}
  f.sequence(:english) {|n| "Leg #{n} miles"}
  f.association   :channel, :factory => :channel
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

Factory.define :herb_category do |f|
  f.name            "Herbs that Resolve the Exterior"
end