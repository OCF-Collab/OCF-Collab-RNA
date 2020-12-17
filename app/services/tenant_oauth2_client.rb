require "delegate"

class TenantOauth2Client < Delegator
  CONNECTION_OPTIONS = {
    request: {
      timeout: 600,
    }
  }

  attr_reader :tenant

  def initialize(tenant:)
    @tenant = tenant
  end

  def __getobj__
    oauth2_client
  end

  def oauth2_client
    @oauth2_client ||= OAuth2::Client.new(
      tenant.oauth_client_id,
      tenant.oauth_client_secret,
      site: request_broker_url,
      connection_opts: CONNECTION_OPTIONS,
    )
  end

  def request_broker_url
    ENV["OCF_COLLAB_URL"]
  end
end
