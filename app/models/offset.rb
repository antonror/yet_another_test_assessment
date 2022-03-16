# Offset model
class Offset < ApplicationRecord
  include CelsiusConstants
  include Valuable

  validates :value, presence: true, numericality: { greater_than: OFFSET_MIN, less_than_or_equal_to: OFFSET_MAX }
end
