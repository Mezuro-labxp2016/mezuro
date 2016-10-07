class CreateMezuroRanges < ActiveRecord::Migration
  def change
    create_table :mezuro_ranges do |t|
      t.float :beginning
      t.float :end
      t.string :comments
      t.belongs_to :reading, index: true
      t.belongs_to :metric_configuration, index: true

      t.timestamps null: false
    end
  end
end
