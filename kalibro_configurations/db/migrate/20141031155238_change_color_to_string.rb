class ChangeColorToString < ActiveRecord::Migration
  def change
    change_column :readings, :color, :string
  end
end
