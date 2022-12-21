require "cgi"

class CompetencyFetcher
  ASSET_FILE_PATH = "/competencies/asset_file"

  attr_reader :id, :tenant

  def initialize(id:, tenant:)
    @id = id
    @tenant = tenant
  end

  def competency
    response_data
  end

  def response_data
    @response_data ||= JSON.parse(body)
  end

  def body
    response.body
  end

  def content_type
    response.content_type
  end

  def status
    response.status
  end

  def response
    @response ||= oauth2_token.get(path, params:)
  end

  def oauth2_token
    oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant:)
  end

  def path
    ASSET_FILE_PATH
  end

  def params
    { id: }
  end
end
