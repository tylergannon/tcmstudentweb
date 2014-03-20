module ETL::Control::ContextRowProcessingDsl
  def before_transform(&block)
    @processor = :after_read
    block.call
    @processor = nil
  end

  def after_transform(&block)
    @processor = :before_write
    block.call
    @processor = nil
  end

  def processor
    @processor || :after_read
  end
  
  def exclude_rows(mapping)
    mapping.each do |field, expression|
      send processor, :exclude_row, field => expression
    end
  end

  def include_rows(mapping)
    mapping.each do |field, expression|
      send processor, :include_row, field => expression
    end
  end
end