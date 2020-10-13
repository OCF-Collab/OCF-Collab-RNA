class CompetencyFrameworksSearch
  SEARCH_PATH = "/api/competency_frameworks/search"

  attr_reader :query

  def initialize(query:)
    @query = query
  end

  def competency_frameworks
    @competency_frameworks ||= response_data["search"]["results"].map do |result|
      result["framework"].symbolize_keys
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
    OCFCollabClient
  end

  def params
    {
      search: {
        query: query,
      }
    }
  end
end
