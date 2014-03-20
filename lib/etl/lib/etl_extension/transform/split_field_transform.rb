class ETL::Transform::SplitFieldTransform < ETL::Transform::Transform
  attr_reader :field, :split_on, :copy_to, :join_string
  def initialize(control, name, config)
    @split_on    = config[:on]
    @copy_to     = config[:to]
    @join_string = config[:join]
    super
  end
  
  def transform(name, value, row)
    return nil unless value

    parts = value.split(split_on)
    copy_to.each do |dest_field, index|
      if index.kind_of? Range
        next unless parts[index]
        row[dest_field] = parts[index].join(join_string)
      else
        row[dest_field] = parts[index]
      end
    end

    value
  end
end
