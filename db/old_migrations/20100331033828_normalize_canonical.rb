class NormalizeCanonical < ActiveRecord::Migration
  def self.up
    Formula.all.each do |f|
      f.canonical = f.canonical.normalize.titleize
      f.save
    end
    Herb.all.each do |h|
      h.canonical = h.canonical.normalize.titleize
      h.save
    end
  end

  def self.down
  end
end
