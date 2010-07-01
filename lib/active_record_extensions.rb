module ActiveRecord
  class Base
    def self.acts_as_cited
      class_eval do
        scope :bensky, lambda {joins(:citation).where("citations.textbook_id = 2")}
        scope :gio, lambda {joins(:citation).where("citations.textbook_id = 20")}
        scope :from_text, lambda { |name|
          tb = Textbook.where("textbooks.abbrev = '#{name}'")
          joins(:citation).where("citations.textbook_id = #{tb[0].id}") unless tb.size==0
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
      where(condition("= '#{str}'"))
    end
    
    def self.named(str)
      equals_condition(str)[0]
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

