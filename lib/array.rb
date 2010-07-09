class Array
  def to_h
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end

  def map_with_index
    result = []
    self.each_with_index do |elt, idx|
      result << yield(elt, idx)
    end
    result
  end
  def plus_if(obj)
    self << obj unless include?(obj) || obj.nil?
  end

  def strip_all
    map!{|t| t.strip}
  end

end

module ArrayPlus
  def +(y)
    y.each do |o|
      self << o unless include?(o)
    end
  end
end

