class AddCanonicalToHerbsFormulasAndAcuPoints < ActiveRecord::Migration
  def self.up
    add_column :acu_points, :canonical, :string
    add_column :herbs, :canonical, :string
    add_column :formulas, :canonical, :string
    norm AcuPoint.all
    norm Herb.all
    norm Formula.all

  end

  def self.norm(a)
    unless a.empty?
      a.each do |o|
        puts o.inspect  
        o.canonical = o.pinyin.normalize
        o.save
      end
    end
  end

  def self.down
    remove_column :acu_points, :canonical
    remove_column :herbs, :canonical
    remove_column :formulas, :canonical
  end
end
