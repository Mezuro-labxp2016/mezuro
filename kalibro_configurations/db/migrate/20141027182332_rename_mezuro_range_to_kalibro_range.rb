class RenameMezuroRangeToKalibroRange < ActiveRecord::Migration
  def change
    rename_table :mezuro_ranges, :kalibro_ranges
  end
end
