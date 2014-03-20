class ETL::Processor::ExcludeRowProcessor < ETL::Processor::RowProcessor
  attr_reader :expected, :field, :operator, :stringify, :my_control
  
  def import
    my_control.instance_variable_get('@import')
  end
  
  def initialize(control, expected_map)
    @my_control = control
    @field, @expected = expected_map.first
    if expected.kind_of?(Regexp)
      @operator = :=~
      @stringify = true
      @match_sentence = "match the regular expression #{expected.inspect}."
    else
      @operator = :==
      @stringify = false
      @match_sentence = "be equal to #{expected.inspect}."
    end
    
    super
  end
  
  def match?(row)
    actual = row[field]
    actual = actual.to_s if stringify
    !!(actual.send operator, expected)
  end
  
  def process(row)
    if match?(row)
      log_exclusion(row) if import
      
      return nil
    else
      return row
    end
  end
  
  def message
    "#{field} should NOT " + @match_sentence
  end
  
  def log_exclusion(row)
    keyword     = row[:keyword]
    email_name  = row[:email_name]
    date        = if keyword && (groups = keyword.match(/-(\d{6})-/))
      Date.strptime(groups[1], "%m%d%y") rescue nil
    elsif email_name && (groups = email_name.match(/(\d{8})_/))
      Date.strptime(groups[1], "%Y%m%d") rescue nil
    end
    
    unless date.nil?
      Reports::Exclusion.create!( campaign_date:  date, 
                                  email_name:     email_name,
                                  import_id:      import.id, 
                                  import_type:    import.class.name, 
                                  keyword:        keyword,
                                  message:        message) 
    end
  end
end
