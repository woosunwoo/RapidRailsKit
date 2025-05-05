class ApplicationController < ActionController::API
    include Devise::Controllers::Helpers
    include Pundit::Authorization
    before_action :authenticate_user!

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
    private
  
    def user_not_authorized
      render json: { error: "Not authorized" }, status: :forbidden
    end
end
  