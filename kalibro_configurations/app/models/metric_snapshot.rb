class MetricSnapshot < ActiveRecord::Base
  has_one :metric_configuration

  validates :name, :code, :scope, presence: true
  validates :metric_collector_name, presence: true, if: "type == 'NativeMetricSnapshot' || type == 'HotspotMetricSnapshot'"
  validates :script, presence: true, if: "type == 'CompoundMetricSnapshot'"

  def as_json(options = {})
    json = super(options)
    # Type is considered by ActiveRecord as an implementation detail and so it is ignored by as_json
    # Here we set it, since it is important in our case
    if self.is_a?(HotspotMetricSnapshot)
      json['type'] = 'HotspotMetricSnapshot'
      json.delete('script')
    elsif self.is_a?(NativeMetricSnapshot)
      json['type'] = 'NativeMetricSnapshot'
      json.delete('script')
    elsif self.is_a?(CompoundMetricSnapshot)
      json['type'] = 'CompoundMetricSnapshot'
      json.delete('metric_collector_name')
    end
    json
  end

  def scope=(value)
    value.is_a?(Hash) ? super(value['type']) : errors.add(:scope, "#{value} invalid")
  end
end
