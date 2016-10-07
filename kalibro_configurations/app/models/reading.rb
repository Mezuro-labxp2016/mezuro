require 'validators/color_validator.rb'

class Reading < ActiveRecord::Base
  belongs_to :reading_group
  has_many :kalibro_ranges, dependent: :destroy

  validates :label, :grade, :color, :reading_group, presence: true
  validates :label, uniqueness: { scope: :reading_group_id,
                                  message: 'Should be unique within a Reading Group' }
  validates :grade, numericality: true
  validates :color, color: true
end
