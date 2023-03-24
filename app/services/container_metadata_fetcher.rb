require "cgi"

class ContainerMetadataFetcher
  METADATA_PATH = "/containers/metadata"

  attr_reader :tenant, :id

  def initialize(tenant:, id:)
    @tenant = tenant
    @id = id
  end

  def container_metadata
    @container_metadata ||= ContainerMetadataParser
      .new(body: response_data)
      .container_metadata
  end

  def response_data
    @response_data ||= JSON.parse(response.body)
  end

  def response
    @response ||= oauth2_token.get(path, params: params)
  end

  def oauth2_token
    oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant: tenant)
  end

  def path
    METADATA_PATH
  end

  def params
    {
      id: id,
    }
  end
end
