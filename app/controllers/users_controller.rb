class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :destroy_action_error

  def destroy
    User.destroy(params[:id])
    head :ok
  end

  private

  def destroy_action_error(exception)
    render plain: exception, status: :bad_request
  end
end
