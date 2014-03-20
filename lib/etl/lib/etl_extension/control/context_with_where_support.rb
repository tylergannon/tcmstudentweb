require 'active_support/concern'

module ETL::Control::ContextWithWhereSupport
  extend ActiveSupport::Concern
  included do
    alias_method_chain :transform, :where_support
  end

  def where(conditions, &block)
    @conditions = conditions
    block.call
    @conditions = nil
  end

  def transform_with_where_support(name, transformer=nil, configuration={}, &block)
    if block_given?
      if @conditions.nil?
        transform_without_where_support(name, &block)
      else
        conditions = @conditions
        transform_without_where_support name do |name, value, row|
          skip = false
          conditions.each do |field, expression|
            if expression.kind_of?(Regexp)
              if (row[field] =~ expression).nil?
                skip = true; break
              end
            elsif expression.kind_of?(Class)
              unless row[field].kind_of?(expression)
                skip = true; break
              end
            elsif row[field] != expression
              skip = true; break
            end
          end
          skip ? value : block.call(name, value, row)
        end
      end
    else
      transform_without_where_support(name, transformer, configuration)
    end
  end
end
