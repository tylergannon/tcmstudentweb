class ETL::Transform::RegexpTransform < ETL::Transform::Transform
  attr_reader :replacements
  def initialize(control, name, replacements)
    super
    @replacements = replacements
  end

  def transform(name, value, row)
    return nil if value.nil?
    replacements.each do |regexp, replacement|
      value = value.gsub regexp, replacement
    end
    
    value
  end
end
