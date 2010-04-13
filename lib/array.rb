class Array
	def to_h
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end

  def find_same(obj)
    select{|o| o =~ obj}[0]
  end

  def plus_if(obj)
    self << obj unless include?(obj) || obj.nil?
  end

end

module ArrayPlus
  def +(y)
    y.each do |o|
      self << o unless include?(o)
    end
  end
end