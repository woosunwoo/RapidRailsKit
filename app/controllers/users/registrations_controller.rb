class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # Disable CSRF check since API-only
  # skip_before_action :verify_authenticity_token

  # Prevent Devise from using sessions
  include ActionController::MimeResponds

  def create
    build_resource(sign_up_params)
  
    if resource.save
      sign_in(resource, store: false) # 🔑 This is what triggers Devise::JWT to issue & attach token
      token = Warden::JWTAuth::UserEncoder.new.call(resource, :user, nil).first
      render json: {
        token: token,
        user: resource
      }, status: :created
    else
      render json: { errors: resource.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def respond_to_on_destroy
    head :no_content
  end
end
