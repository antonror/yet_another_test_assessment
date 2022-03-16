# Temperature model
class Temperature < ApplicationRecord
  include CelsiusConstants
  include Valuable

  belongs_to :user
  validates :value, presence: true, numericality: { greater_than: BODY_MIN, less_than_or_equal_to: BODY_MAX }
end
