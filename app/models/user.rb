class User < ApplicationRecord
  # ... devise modules ...
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  has_many :projects, dependent: :destroy

  def jwt_subject
    id
  end
end
