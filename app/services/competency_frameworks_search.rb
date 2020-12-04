class CompetencyFrameworksSearch
  SEARCH_PATH = "/competency_frameworks/search"

  attr_reader :tenant, :query

  def initialize(tenant:, query:)
    @tenant = tenant
    @query = query
  end

  def competency_frameworks_metadata
    @competency_frameworks ||= response_data["search"]["results"].map do |result|
      CompetencyFrameworkMetadataParser.new(framework_metadata: result).competency_framework_metadata
    end
  end

  def response_data
    @response_data ||= JSON.parse(response.body)
  end

  def response
    @response ||= oauth2_token.get(SEARCH_PATH, params: params)
  end

  def oauth2_token
    oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant: tenant)
  end

  def params
    {
      search: {
        query: query,
      }
    }
  end
end
