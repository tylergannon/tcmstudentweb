class CreateAcuPointCategoriesChannelsJoinTable < ActiveRecord::Migration
  def self.up
    create_table "#{'acu_point_category'.pluralize}_#{'channel'.pluralize}".to_sym, :id => false do |t|
      t.integer :acu_point_category_id
      t.integer :channel_id
    end
    add_index "#{'acu_point_category'.pluralize}_#{'channel'.pluralize}".to_sym, :channel_id
    add_index "#{'acu_point_category'.pluralize}_#{'channel'.pluralize}".to_sym,
                :acu_point_category_id
  end

  def self.down
    drop_table "#{'acu_point_category'.pluralize}_#{'channel'.pluralize}".to_sym
  end


end

