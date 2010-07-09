module ActiveRecord
  class Base
    def self.acts_as_cited
      class_eval do
        belongs_to :citation, :dependent => :destroy
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
    
    def self.search_on(*cols)
      class_eval "def self.search_columns; #{cols.map{|t| t.to_s}.to_ary.inspect}; end;"
      class_eval do
        scope :search, lambda{|str|
          items = like_condition(str.downcase)
          if scopes.has_key?(:search_mod)
            items = items.search_mod
          end
          items
        }
      end
    end
    
    def self.lookup(params)
      str = params[:id]
      if str.match(/\D/)
        named(str)
      else
        find(str)
      end
    end

    def self.like_condition(str)
      where(condition("ilike '%#{str}%'"))
    end

    def self.equals_condition(str)
      where(condition("= '#{str.downcase}'"))
    end
    
    def self.named(str)
      equals_condition(str.downcase)[0]
    end

    def self.search_columns
      []
    end

    def self.find_or_create(field, value)
      value = value.to_s.strip
      return if value.empty?
      a = find(:first, :conditions => "lower('#{value}') = lower(#{field.to_s})")
      a ||= create(field => value)
    end

    def link_name
      name
    end

    def link_title
      ""
    end

    def self.find_by_textbook(text)
      textbook_ids = Textbook.search(text).map{|v| v.id}
      find(:all, :joins => :citation, :conditions => "citations.textbook_id in (#{textbook_ids.join(", ")})")
      # Formula.find(:all, :joins => :citation, :conditions => {:citations => {:textbook_id => a.id }})

    end


    def self.condition(cond)
       search_columns.map{|c| "trim(lower(#{c})) #{cond}"}.join(" or ")
    end
  end
end

