class ObjectHasher
  def self.hash_formula(f)
    a = {
            :pinyin => f.pinyin,
            :english => f.english,
            :preparation => f.preparation,
            :formula_category_name => f.formula_category_name,
            :commentary => f.commentary}
    [f.formula_contraindications,
     f.formula_symptoms,
     f.formula_therapeutic_functions,
     f.formula_herbs].each {|c| hash_collection(a, c)}

    a
  end

  def self.hash_acu_point(ap)
    h = {}
    ["id", "channel_id", "ordinal", "english", "pinyin"].each {|param| set_param?(h, param, ap)}
    [ap.acu_point_symptoms, ap.acu_point_therapeutic_functions].each {|c| hash_collection(h, c)}
    h
  end

  def self.hash_formula_contraindication(fc)
    b = {}
    set_param? b, "id", fc
    set_param? b, "contraindication_name", fc
    b
  end

  def self.hash_formula_dui_yao(formula_dui_yao)
    c = {}
    ["formula_id", "herb1_pinyin", "herb2_pinyin", "commentary"].each {|param| set_param?(c, param, formula_dui_yao)}
    c
  end

  def self.hash_formula_symptom(fs)
    c = {}
    set_param? c, "id", fs
    set_param? c, "symptom_name", fs
    c
  end

  def self.hash_formula_herb(h)
    a = {}
    ["id", "herb_pinyin", "formula_role_id", "dose", "commentary"].each {|p| set_param?(a, p, h)}
    a
  end

  def self.hash_formula_therapeutic_function(tf)
    a = {}
    set_param? a, "id", tf
    set_param? a, "therapeutic_function_name", tf
  end


  private

  def self.hash_collection(hash, array)
    return unless array && array.size>0
    class_name = array[0].class.name.underscore
    plural_name = class_name.tableize
    hash["#{plural_name}_attributes"] = map_obj(array) do |obj|
      self.send("hash_#{class_name}", obj)
    end
  end

  def self.set_param?(h, prm, obj)
    if obj.send(prm) != nil then
      h[prm] = obj.send(prm)
    end
  end

  def self.map_obj(ary, &code)
    Hash[ary.map{|c|
      [ary.index(c).to_s, code.call(c)]
    }]
  end


end