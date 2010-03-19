class Array
	def to_h
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end

  def find_same(obj)
    select{|o| o =~ obj}[0]
  end
end
