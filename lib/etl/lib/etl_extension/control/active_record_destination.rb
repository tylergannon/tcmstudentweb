class ETL::Control::ActiveRecordDestination < ETL::Control::Destination
  # The klass
  attr_reader :klass
  
  # Specify the order from the source
  attr_reader :order
  
  # Specify the primarykey from the source
  attr_reader :primarykey
  
  # Set to true to truncate the destination klass first
  attr_reader :truncate
  
  # Initialize the database destination
  # 
  # * <tt>control</tt>: The ETL::Control::Control instance
  # * <tt>configuration</tt>: The configuration Hash
  # * <tt>mapping</tt>: The mapping
  #
  # Configuration options:
  # * <tt>:database</tt>: The database name (REQUIRED)
  # * <tt>:target</tt>: The target connection (REQUIRED)
  # * <tt>:klass</tt>: The klass to write to (REQUIRED)
  # * <tt>:truncate</tt>: Set to true to truncate before writing (defaults to false)
  # * <tt>:unique</tt>: Set to true to only insert unique records (defaults to false)
  # * <tt>:append_rows</tt>: Array of rows to append
  #
  # Mapping options:
  # * <tt>:order</tt>: The order of fields to write (REQUIRED)
  # * <tt>:primarykey</tt>: The primary key of fields to select insert or update (REQUIRED)
  def initialize(control, configuration, mapping={})
    super
    @klass = configuration[:klass]
    @truncate = configuration[:truncate] ||= false
    @order = mapping[:order] ? mapping[:order] + scd_required_fields : order_from_source
    @order.uniq! unless @order.nil?
    @primarykey = mapping[:primarykey] ? mapping[:primarykey] + scd_required_fields : nil
    @primarykey.uniq! unless @primarykey.nil?
    raise "Primarykey required in mapping" unless @primarykey
    raise "Order required in mapping" unless @order
    raise "Klass required" unless @klass
  end
  
  # Flush the currently buffered data
  def flush
    buffer.flatten.each do |row|
      next unless row_allowed?(row)
      add_virtuals!(row)
      primary_key_filter = {}
      primarykey.each do |name|
        primary_key_filter[name] = row[name]
      end
      obj = klass.where(primary_key_filter).first
      if obj
        ETL::Engine.logger.debug("Row #{current_row} found #{klass} with ID=#{obj.id}")
        obj.update_attributes row.slice(*order)
      else
        ETL::Engine.logger.debug("Row #{current_row} creating new #{klass}")
        klass.create! row.slice(*order)
      end
      @current_row += 1
    end
    buffer.clear
  end
  
  # Close the connection
  def close
    buffer << append_rows if append_rows
    flush
  end
  
  private
  def conn

  end
  
  def table_name
  end
end
