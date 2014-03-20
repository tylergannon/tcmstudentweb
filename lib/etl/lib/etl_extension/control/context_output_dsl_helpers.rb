module ETL::Control::ContextOutputDslHelpers
  def insert_into_database(db_name, table_name, output_options)
    output_options.replace_keys! :columns => :order
    if output_options[:truncate] == true
      ETL::Engine.connection(db_name.to_sym).execute("DELETE FROM [#{table_name}];")
    end
    db_options = {
      type: :database,
      target: db_name.to_sym,
      table:  table_name.to_s
    }
    destination :out, db_options, output_options
  end

  def insert_by_class(klass, target_db=nil, params={})
    target_db ||= Rails.env
    params[:columns] ||= klass::IMPORT_ATTRIBUTES
    insert_into_database target_db, klass.table_name, params
  end
  
  def insert_update_by_class(klass, target_db=nil)
    target_db ||= Rails.env
    insert_update_database target_db, klass.table_name, 
                            columns: klass::IMPORT_ATTRIBUTES, 
                            primarykey: klass::IMPORT_UNIQUE_KEY
  end
  
  def insert_update_database(db_name, table_name, output_options)
    output_options.replace_keys! :columns => :order
    db_options = {
      type: :insert_update_database,
      target: db_name.to_sym,
      table:  table_name.to_s# ,
#       truncate: output_options[:truncate] || false
    }
    destination :out, db_options, output_options.except(:truncate)
  end
end