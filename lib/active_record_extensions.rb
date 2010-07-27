module TcmStudentWeb
  class ActiveRecord::Base
    def html_id
      new_record? ? "new" : id.to_s
    end
    def element_id(prefix=nil)
      (prefix ? "#{prefix.to_s}_" : "") + "#{self.class.name.underscore}_#{html_id}"
    end
  end
  module ActiveRecordExtensions
    def find_by_name
#      class_eval do
#        def self.find(*args)
#          if args[0].is_numeric?
#            super(args)
#          else
#            named(args[0])
#          end
#        end
#      end
    end
    def simple_association_text(association, options={})
      delim = options[:delim] ||= ','
      association = association.to_s.tableize
      find_by = showby = options[:find_by].to_s
      klass = association.to_s.singularize.camelize
      create_str = "a = a ||= #{klass}.create(:#{find_by}=>name)" if options[:create]

      class_eval \
       "    def #{association}_text=(text)
              delim = '#{delim}'
              self.#{association} = text \
                 .split('#{delim}') \
                 .strip_each \
                 .reject{|t|t.empty?} \
                 .map{|name|
                    a = #{klass}.named(name)
                    #{create_str}
                 } \
                 .reject{|t|t.nil?}
            end
            def #{association}_text
              #{association}.map{|t| t.#{showby}}.join('#{delim}')
            end
        "
    end


    def acts_as_cited
      class_eval do
        belongs_to :citation
        accepts_nested_attributes_for :citation, :allow_destroy => true, :reject_if => proc {|a| a['textbook_title'].blank?}
        scope :bensky, lambda {joins(:citation).where("citations.textbook_id = 2")}
        scope :gio, lambda {joins(:citation).where("citations.textbook_id = 20")}

        scope :order_by_text, joins(:citation).order('citations.textbook_id')

        scope :from_text, lambda { |name|
          tb = Textbook.where("textbooks.abbrev = '#{name}'")
          joins(:citation).where("citations.textbook_id = #{tb[0].id}") unless tb.size==0
        }
      end
    end
  end
end

