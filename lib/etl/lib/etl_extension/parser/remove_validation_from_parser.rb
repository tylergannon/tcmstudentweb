require 'active_support/concern'

module ETL::Parser::RemoveRowValidationFromParser
  extend ActiveSupport::Concern
  def validate_row_with_validation_option(row, line, file)
    
  end
  
  def configure_with_validation_option
    
    
  end
  
  included do
    attr_reader :validate_rows
    alias_method_chain :validate_row, :validation_option
    alias_method_chain :configure,    :validation_option
  end
end