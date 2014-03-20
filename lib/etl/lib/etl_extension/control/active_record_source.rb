class ETL::Control::ActiveRecordSource < ETL::Control::Source
  attr_accessor :target, :map
  def initialize(control, configuration, definition)
    super
    @target = configuration[:target]
    @map    = configuration[:map]
  end
  
  def name
    :object
  end
  
  # Get a String identifier for the source
  def to_s
    target.inspect
  end
  
  # Get the number of rows in the source
  def count(use_cache=true)
    return @count if @count && use_cache
    @count = target.call().size()
  end
  
  # Get the list of columns to read. This is defined in the source
  # definition as either an Array or Hash
  def columns
    map.keys
  end
  
  # Returns each row from the source. If read_locally is specified then
  # this method will attempt to read from the last stored local file. 
  # If no locally stored file exists or if the trigger file for the last
  # locally stored file does not exist then this method will raise an
  # error.
  def each(&block)
    target.call().find_each do |model|
      row = ETL::Row.new()
      row[self.name] = model
      if map.nil?
        model.attributes.symbolize_keys.each{|k,v| row[k]=v}
      else
        map.each do |obj|
          if obj.kind_of?(Symbol)
            row[obj] = model.send(obj)
          elsif obj.kind_of?(Hash)
            obj.each do |key, val|
              if val.kind_of?(Proc)
                row[key] = val.call(model)
              else
                row[key] = model.resolve_value(val)
              end
            end
          end
        end
      end
      block.call(row)
    end
  end
end
