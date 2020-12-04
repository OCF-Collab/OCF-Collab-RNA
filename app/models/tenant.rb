class Tenant < ApplicationRecord
  validates :name, presence: true
  validates :oauth_client_id, presence: true
  validates :oauth_client_secret, presence: true

  has_many :tenant_tokens
end
