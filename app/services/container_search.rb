class ContainerSearch
  SEARCH_PATH = "/containers/search"
  PER_PAGE = 10

  attr_reader :tenant, :query, :page

  def initialize(tenant:, query:, page:)
    @tenant = tenant
    @query = query
    @page = page
  end

  def containers_metadata
    @containers_metadata ||= search_data["results"].map do |result|
      ContainerMetadataParser.new(container_metadata: result).container_metadata
    end
  end

  def total_results_count
    search_data["total_results_count"]
  end

  def per_page
    search_data["per_page"]
  end

  def page
    @page || 1
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
    response_data["search"]
  end

  def response_data
    @response_data ||= JSON.parse(response.body)
  end

  def response
    @response ||= oauth2_token.get(SEARCH_PATH, params: params)
  end

  def oauth2_token
    @oauth2_token = oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant: tenant)
  end

  def params
    {
      query: query,
      per_page: PER_PAGE,
      page: page,
    }
  end
end
