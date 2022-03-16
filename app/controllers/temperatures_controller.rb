class TemperaturesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :create_action_error

  before_action :current_user
  after_action :send_notification, only: :create

  def create
    @temperature = Temperature.create!(user: @current_user, value: params[:value])
    render plain: "Temperature reading with #{@temperature.value} C added", status: :accepted
  end

  def index
    render json: @current_user&.temperatures&.limit(10) || []
  end

  private

  def current_user
    @current_user ||= User.find_by_id(params[:user_id])
  end

  def temperatures_params
    params.require(:value)
  end

  def create_action_error(exception)
    render plain: exception, status: :bad_request
  end

  def send_notification
    notify_user = NotificationService.new(@current_user).notify_user? if @current_user.temperatures.count >= 5

    p "#{@current_user.email}: YOU ARE GOING TO GET SICK!" if notify_user
  end
end
