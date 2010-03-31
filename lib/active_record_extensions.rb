module ActiveRecord
  class Base
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
      str = str.to_s.strip
      return all if str.empty?
      if /^\d+$/.match(str)
        find(str)
      else
        str = str.strip.gsub(/[-_+]/, " ").gsub(/%20/, " ").downcase

        if symbol == :first
          conditions = search_columns.map{|c| "trim(lower(#{c})) = '#{str}'"}.join(" or ")
          if a = find(:first, :conditions => conditions)
            a
          else
            conditions = search_columns.map{|c| "trim(lower(#{c})) like '%#{str}%'"}.join(" or ")
            find(:first, :conditions => conditions)
          end
        else
          conditions = search_columns.map{|c| "trim(lower(#{c})) like '%#{str}%'"}.join(" or ")
          find(symbol, :conditions => conditions)
        end
      end
    end
  end
end