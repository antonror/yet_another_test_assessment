# Notification service
class NotificationService
  include CelsiusConstants

  def initialize(user)
    @user = user
    @last_five_values = user.temperatures.last(5).map(&:value)
    @offset_value = Offset.sole.value
  end

  def notify_user?
    if assert_sequence_length && was_offset_defined?
      last_five_values_offset = @last_five_values.map{|value| value + @offset_value}
      final_record = last_five_values_offset.last
      final_record >= (ILLNESS_THRESHOLD - PREDICTION_GAP) && ascending_sequence?(last_five_values_offset)
    else
      false
    end
  end

  private

  def assert_sequence_length
    @last_five_values.count >= 5
  end

  def was_offset_defined?
    @offset_value.present?
  end

  def ascending_sequence?(sequence)
    sequence.each_cons(2).all? {|previous_value, next_value| previous_value < next_value }
  end
end
