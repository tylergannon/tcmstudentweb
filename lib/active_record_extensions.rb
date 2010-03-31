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

    

  end
end