# spec/support/jwt_helper.rb
module JwtHelper
  def self.secret
    # Must match what's in devise.rb jwt config
    ENV['DEVISE_JWT_SECRET_KEY'] || Rails.application.credentials.devise_jwt_secret_key || 'your_test_secret'
  end

  def self.encode(payload)
    JWT.encode(payload.merge(exp: 24.hours.from_now.to_i), secret, 'HS256')
  end
end
