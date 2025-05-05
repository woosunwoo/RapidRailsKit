class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    token = request.env['warden-jwt_auth.token']
    response.set_header('Authorization', "Bearer #{token}")
    Rails.logger.info "Login token issued: #{token}"

    render json: {
      token: token,
      user: {
        id: resource.id,
        email: resource.email
      }
    }, status: :ok
  end


  def respond_to_on_destroy
    head :no_content
  end
end
