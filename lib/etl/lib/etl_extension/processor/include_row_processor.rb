class ETL::Processor::IncludeRowProcessor < ETL::Processor::ExcludeRowProcessor
  def match?(row)
    !super(row)
  end

  def message
    "#{field} SHOULD " + @match_sentence
  end
end
