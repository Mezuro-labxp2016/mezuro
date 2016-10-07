class CreateKalibroConfigurations < ActiveRecord::Migration
  def change
    create_table :kalibro_configurations do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
