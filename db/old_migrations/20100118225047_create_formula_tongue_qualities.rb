class CreateFormulaTongueQualities < ActiveRecord::Migration
  def self.up
    create_table :formula_tongue_qualities do |t|
      t.integer :formula_id
      t.integer :tongue_quality_id

      t.timestamps
    end
  end

  def self.down
    drop_table :formula_tongue_qualities
  end
end
