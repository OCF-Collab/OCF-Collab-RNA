require "cgi"

class CompetencyFrameworkMetadataFetcher
  METADATA_PATH = "/competency_frameworks/metadata"

  attr_reader :tenant, :id

  def initialize(tenant:, id:)
    @tenant = tenant
    @id = id
  end

  def competency_framework_metadata
    @competency_framework_metadata = CompetencyFrameworkMetadataParser.new(
      framework_metadata: framework_metadata
    ).competency_framework_metadata
  end

  def framework_metadata
    response_data
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
