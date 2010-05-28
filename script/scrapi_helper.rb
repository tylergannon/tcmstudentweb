require 'rubygems'
require 'scrapi'
require 'htmlentities'
require 'yaml'
$KCODE = 'UTF8'
require 'ya2yaml'

class Struct
  def to_hash
    a = {}
    each_pair {|name, val| a[name]=val}
    a
  end
end

