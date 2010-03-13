module ActiveRecord
  class Base
    def =~ (other)
      if other.nil? || (other.class != self.class)
        false
      else
        other.name.downcase == name.downcase
      end
    end

    def << (other)
      return if other.nil? || (other.class != self.class) || other.new_record? || !(self =~ other)
      key_attributes.each do |attribute|
        old_val = other.send(attribute)
        new_val = send(attribute)

        if new_val.to_s.blank? && !old_val.to_s.blank?
          send(attribute + "=", old_val)
        end
      end
    end

    def write_attributes
      key_attributes.to_h{|a| {a.to_s => get_attribute(a).to_s} }.delete_if{|k,v| v.to_s.empty?}
    end

    def get_attribute(attr)
      val = send(attr)
      unless val.nil?
        if val.class == TrueClass || val.class == FalseClass
          val = val ? "1" : "0"
        end
        val
      end
    end
  end
end