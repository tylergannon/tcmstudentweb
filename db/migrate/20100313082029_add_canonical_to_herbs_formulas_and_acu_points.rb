class AddCanonicalToHerbsFormulasAndAcuPoints < ActiveRecord::Migration
  def self.up
    add_column :acu_points, :canonical, :string
    add_column :herbs, :canonical, :string
    add_column :formulas, :canonical, :string

    [AcuPoint.all, Herb.all, Formula.all].each {|p| norm(p)}

  end

  def self.norm(a)
    a.each do |o|
      o.canonical = o.pinyin.normalize
      o.save
    end
  end

  def self.down
    remove_column :acu_points, :canonical
    remove_column :herbs, :canonical
    remove_column :formulas, :canonical
  end
end
