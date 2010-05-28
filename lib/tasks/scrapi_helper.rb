require 'rubygems'
require 'scrapi'
require 'htmlentities'
require 'yaml'
$KCODE = 'UTF8'
require 'ya2yaml'

class Struct
  def to_hash
    a = {}
    each_pair {|name, val|
      if val.type == Struct
        a[name] = val.to_hash
      else
        a[name]=val
      end
    }
    a
  end
end

