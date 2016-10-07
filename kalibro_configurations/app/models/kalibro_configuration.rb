class KalibroConfiguration < ActiveRecord::Base
  has_many :metric_configurations, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def hotspot_metric_configurations
    MetricConfiguration.joins(:metric_snapshot).where(metric_snapshots: { type: 'HotspotMetricSnapshot' },
                                                      kalibro_configuration_id: id)
  end

  def tree_metric_configurations
    MetricConfiguration.joins(:metric_snapshot).where.not(metric_snapshots: { type: 'HotspotMetricSnapshot' })
      .where(kalibro_configuration_id: id)
  end
end
