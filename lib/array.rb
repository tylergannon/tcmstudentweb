class Array
  def write_attributes(old_a=[])
    attr = to_h{|obj|
      if (old = old_a.find_same(obj))
        obj << old
      end
      {index(obj).to_s => obj.write_attributes}
    }
    old_a.each do |old|
      unless find_same(old)
        attr[attr.size.to_s] = {'id' => old.id.to_s, '_destroy' => '1'}
      end
    end
    attr
  end

	def to_h
    map { |e| yield e }.inject({}) { |carry, e| carry.merge! e }
  end

  def find_same(obj)
    select{|o| o =~ obj}[0]
  end
end
