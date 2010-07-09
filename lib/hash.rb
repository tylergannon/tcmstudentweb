module HashExtension
  def copy_without_destroy
    a = {}
    self.each {|key,val| a[key]=val unless key.to_s == "_destroy"}
    a
  end
end
