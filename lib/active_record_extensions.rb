module ActiveRecord
  class Base
    def self.acts_as_cited
      class_eval do
        scope :bensky, lambda {joins(:citation).where("citations.textbook_id = 2")}
        scope :gio, lambda {joins(:citation).where("citations.textbook_id = 20")}
        
        scope :order_by_text, joins(:citation).order('citations.textbook_id')
        
        scope :from_text, lambda { |name|
          tb = Textbook.where("textbooks.abbrev = '#{name}'")
          joins(:citation).where("citations.textbook_id = #{tb[0].id}") unless tb.size==0
        }
      end
    end
    
    def self.named_association(member, klass, attribute, create=nil)
      member = member.to_s
      klass = klass.name
      attribute = attribute.to_s
      if create
        class_eval "def #{member}_#{attribute}=(#{attribute}); 
        return if #{attribute}.blank?
        self.#{member} = #{klass}.named(#{attribute})
        self.#{member} = self.#{member} ||= #{klass}.create(:#{attribute} => #{attribute})
        end;"
      else
        class_eval "def #{member}_#{attribute}=(#{attribute}); self.#{member} = #{klass}.named(#{attribute}) unless #{attribute}.blank?; end;"
      end
      class_eval "def #{member}_#{attribute}; #{member}.#{attribute} if #{member}; end;"
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
    
    def =~ (other)
      if other.nil? || (other.class != self.class)
        false
      else
        other.name.downcase == name.downcase
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

    def incorporate(new_obj)
      return if new_obj.nil? || (new_obj.class != self.class) || !(self =~ new_obj)
      attr = {}
      key_attributes.each do |attribute|
        new_val = new_obj.attributes[attribute]
        unless new_val.to_s.nil?
          attr[attribute] = new_val
        end
      end
      self.attributes = attr
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

