class ClusterVisits < ActiveRecord::Migration
  def change
    reversible do |direction|
      direction.up do
        execute <<-SQL
          CLUSTER clinic_visits USING index_clinic_visits_on_slug;
        SQL
      end
      
      direction.down do
        execute <<-SQL
          ALTER TABLE clinic_visits SET WITHOUT CLUSTER;
        SQL
      end
    end
  end
end
