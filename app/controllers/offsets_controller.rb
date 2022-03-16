class OffsetsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :update_action_error

  before_action :current_offset

  def update
    @current_offset.update!(value: params[:value])
    render plain: "Offset rate was set to #{@current_offset.value} C", status: :accepted
  end

  private

  def current_offset
    @current_offset ||= Offset.sole
  end

  def update_action_error(exception)
    render plain: exception, status: :bad_request
  end
end
