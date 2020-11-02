require "cgi"

class CompetencyFrameworkFetcher
  COMPETENCY_FRAMEWORK_PATH = "/api/competency_frameworks"

  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def competency_framework
    @competency_framework ||= CompetencyFrameworkParser.new(body: response_data).competency_framework
  end

  def response_data
    @response_data ||= JSON.parse(response.body)
  end

  def response
    @response ||= oauth2_token.get(path)
  end

  def oauth2_token
    oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    OCFCollabClient
  end

  def path
    "%s/%s/asset_file" % [
      COMPETENCY_FRAMEWORK_PATH,
      CGI.escape(id),
    ]
  end
end
