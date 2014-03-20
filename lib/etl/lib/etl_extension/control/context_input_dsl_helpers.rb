module ETL::Control::ContextInputDslHelpers
  def query_input(db_name, query, columns)
    source :in, {
      :type => :database,
      :target => db_name,
      query: query
      }, columns
  end
  
  def excel_input(filename, options={})
    source_options = [:skip_lines]
    source_arguments = {
      file: filename, parser: :excel, validate_rows: false
    }.merge(options.slice(*source_options))

    excel_args = options.except(*source_options)
    if excel_args.has_key? :worksheets
      if excel_args[:worksheets].kind_of? Range
        excel_args[:worksheets] = excel_args[:worksheets].to_a
      end
      excel_args[:worksheets] = [excel_args[:worksheets]].flatten
    end

    source :in, source_arguments, excel_args
  end

  def csv_input(filename, options={})
    source_options = [:skip_lines]
    source_arguments = {
      file: filename, parser: :csv, validate_rows: false
    }.merge(options.slice(*source_options))

    csv_args = options[:fields]

    source :in, source_arguments, csv_args
  end
end