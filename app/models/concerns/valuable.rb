# normalize value for human-readable purposes
module Valuable
  extend ActiveSupport::Concern

  def value
    super.to_f
  end
end
