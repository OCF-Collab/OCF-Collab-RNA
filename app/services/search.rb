class Search
  SEARCH_PATH = "/search"
  PER_PAGE = 10

  attr_reader :competency_query, :container_query, :tenant

  def initialize(competency_query: nil, container_query: nil, page: 1, tenant:)
    @competency_query = competency_query
    @container_query = container_query
    @page = page
    @tenant = tenant
  end

  def results
    search_data.fetch("results")
  end

  def competency_results_count
    search_data.fetch("competency_results_count")
  end

  def container_results_count
    search_data.fetch("container_results_count")
  end

  def total_results_count
    return container_results_count if container_query.present?

    competency_results_count
  end

  def per_page
    search_data.fetch("per_page")
  end

  def page
    (@page || 1).to_i
  end

  def has_pages?
    total_results_count > per_page
  end

  def has_next_page?
    per_page * page < total_results_count
  end

  def next_page
    return nil unless has_next_page?

    page + 1
  end

  def has_previous_page?
    page > 1
  end

  def previous_page
    return nil unless has_previous_page?

    page - 1
  end

  def search_data
    response_data.fetch("search")
  end

  def response_data
    @response_data ||= JSON.parse(response.body)
  end

  def response
    @response ||= oauth2_token.get(SEARCH_PATH, params:)
  end

  def oauth2_token
    @oauth2_token = oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant: tenant)
  end

  def params
    { competency_query:, container_query:, page:, per_page: PER_PAGE }
  end
end
