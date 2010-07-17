class AddAcuPointTherapeuticFunctions${2}sJoinTable < ActiveRecord::Migration
def self.up
  create_table :${1}s_${2}s, :id => false do |t|
    t.integer :${1}_id
    t.integer :${2}_id
  end
  add_index :${1}s_${2}s, :${2}_id
  add_index :${1}s_${2}s,
              :${1}_id
end

def self.down
  drop_table :${1}s_${2}s
end
end

