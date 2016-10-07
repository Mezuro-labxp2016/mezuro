class MetricConfiguration < ActiveRecord::Base
  belongs_to :kalibro_configuration
  belongs_to :metric_snapshot, dependent: :destroy
  belongs_to :reading_group
  has_many :kalibro_ranges, dependent: :destroy

  validates :weight, :kalibro_configuration, :metric_snapshot, presence: true, unless: 'hotspot_metric_snapshot?'
  validates :weight, numericality: { greater_than: 0 }, unless: 'hotspot_metric_snapshot?'
  validates :aggregation_form, presence: true, if: 'native_metric_snapshot? && !hotspot_metric_snapshot?'

  accepts_nested_attributes_for :metric_snapshot

  def as_json(options = {})
    options[:except] = :metric_snapshot_id
    json = super(options)
    json['metric'] = metric_snapshot.as_json(except: [:id, :created_at, :updated_at])

    json
  end

  def native_metric_snapshot?
    !metric_snapshot.nil? && metric_snapshot.type == 'NativeMetricSnapshot'
  end

  def hotspot_metric_snapshot?
    !metric_snapshot.nil? && metric_snapshot.type == 'HotspotMetricSnapshot'
  end

  def valid_metric_snapshot_code?(code)
    kalibro_configuration = KalibroConfiguration.find self.kalibro_configuration_id
    kalibro_configuration.metric_configurations.each do |metric_configuration|
      if metric_configuration.id != self.id && code == metric_configuration.metric_snapshot.code
        self.errors[:code] << 'must be unique within a kalibro configuration'
        return false
      end
    end
    true
  end
end
