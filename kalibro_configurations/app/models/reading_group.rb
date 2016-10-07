class ReadingGroup < ActiveRecord::Base
  has_many :readings, dependent: :destroy
  has_many :metric_configurations

  validates :name, presence: true, uniqueness: true
end
