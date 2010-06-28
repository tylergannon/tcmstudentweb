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
        scope :named, lambda {|name|
          where(condition("= '#{name}'"))
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

    def self.search(str, symbol = :all)
      return search_one(str) if symbol == :first

      str = str.to_s.strip.downcase

      if str.empty?
        find(:all)
      elsif /^\d+$/.match(str)
        find(str)
      else
        result = find(:all, :conditions => condition("= '#{str}'"))
        result.extend(ArrayPlus)
        [ find(:all, :conditions => condition("like '#{str}%'")),
          find(:all, :conditions => condition("like '%#{str}%'"))].each do |a|
          a.each do |b|
            result << b unless result.include?(b)
          end
        end

        result
      end
    end

    def self.search_columns
      []
    end

    def self.search_one(str)
      str = str.to_s.strip.downcase

      if str.empty?
        nil
      elsif /^\d+$/.match(str)
        find (str)
      elsif a = find(:first, :conditions => condition("= '#{str}'"))
        a
      elsif a = find(:first, :conditions => condition("like '#{str}%'"))
        a
      else
        find(:first, :conditions => condition("like '%#{str}%'"))
      end
    end

    def self.search_equals(str)
      str = str.to_s.strip.downcase
      if str.empty?
        nil
      else
        find(:first, :conditions => condition("= '#{str}'"))
      end
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


    private
      def self.condition(cond)
         search_columns.map{|c| "trim(lower(#{c})) #{cond}"}.join(" or ")
      end
  end
end

