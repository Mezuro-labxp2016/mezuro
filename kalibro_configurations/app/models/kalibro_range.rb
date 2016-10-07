require 'validators/interval_validator.rb'
require 'validators/range_overlapping_validator.rb'

class KalibroRange < ActiveRecord::Base
  belongs_to :reading
  belongs_to :metric_configuration

  validates :beginning, :end, :reading, :metric_configuration, presence: true
  validates :beginning, uniqueness: {scope: :metric_configuration_id, message: 'Should be unique within a Metric Configuration'}
  validates :beginning, :end, numericality: true
  validates_with IntervalValidator, fields: [:beginning, :end], if: 'beginning && self.end && beginning.is_a?(Numeric) && self.end.is_a?(Numeric)'
  validates_with RangeOverlappingValidator, fields: [:beginning, :end], if: 'beginning && self.end && beginning.is_a?(Numeric) && self.end.is_a?(Numeric)'

  def as_json(options = {})
    options[:except] = [:beginning, :end]
    json = super(options)
    if beginning == -Float::INFINITY
      json['beginning'] = '-INF'
    else
      json['beginning'] = beginning == Float::INFINITY ? 'INF' : beginning
    end
    if self.end == -Float::INFINITY
      json['end'] = '-INF'
    else
      json['end'] = self.end == Float::INFINITY ? 'INF' : self.end
    end

    json
  end

  def beginning=(value)
    super(extract_infinity value)
  end

  def end=(value)
    super(extract_infinity value)
  end

  private

  def extract_infinity(parameter)
    if parameter == 'INF'
      Float::INFINITY
    elsif parameter == '-INF'
      -Float::INFINITY
    else
      parameter
    end
  end
end
