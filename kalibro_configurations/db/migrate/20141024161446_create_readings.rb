class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.string :label
      t.float :grade
      t.integer :color
      t.belongs_to :reading_group, index: true

      t.timestamps null: false
    end
  end
end
