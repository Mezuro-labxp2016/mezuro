class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string :type
      t.string :name
      t.text :description
      t.string :code
      t.string :metric_collector_name
      t.string :scope
      t.text :script

      t.timestamps null: false
    end
  end
end
