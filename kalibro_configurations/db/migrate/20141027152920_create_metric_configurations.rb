class CreateMetricConfigurations < ActiveRecord::Migration
  def change
    create_table :metric_configurations do |t|
      t.integer :metric_id
      t.float :weight
      t.string :aggregation_form
      t.integer :reading_group_id
      t.integer :kalibro_configuration_id

      t.timestamps null: false
    end
  end
end
