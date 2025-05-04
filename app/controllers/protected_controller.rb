class ProtectedController < ApplicationController
  before_action :authenticate_user!

  def demo
    Rails.logger.debug("JWT Current User: #{current_user.inspect}")
    render json: {
      message: "You are authenticated!",
      user: {
        email: current_user.email
      }
    }
  end
end
