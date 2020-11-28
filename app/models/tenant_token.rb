require "securerandom"

class TenantToken < ApplicationRecord
  validates :tenant, presence: true
  validates :token, presence: true
  validates :active, inclusion: { in: [ true, false ] }

  belongs_to :tenant

  before_validation :generate_token

  def generate_token
    self.token ||= SecureRandom.uuid.gsub("-", "")
  end
end
