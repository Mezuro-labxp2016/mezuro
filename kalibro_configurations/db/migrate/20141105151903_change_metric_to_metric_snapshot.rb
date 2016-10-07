class ChangeMetricToMetricSnapshot < ActiveRecord::Migration
  def change
    rename_table :metrics, :metric_snapshots
    change_table :metric_configurations do |t|
      t.rename :metric_id, :metric_snapshot_id
    end
  end
end
