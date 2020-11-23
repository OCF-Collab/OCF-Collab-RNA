require "cgi"

class CompetencyFrameworkMetadataFetcher
  METADATA_PATH = "/api/competency_frameworks"

  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def competency_framework_metadata
    @competency_framework_metadata = CompetencyFrameworkMetadataParser.new(framework_metadata: framework_metadata).competency_framework_metadata
  end

  def framework_metadata
    response_data
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
    "%s/%s" % [
      METADATA_PATH,
      CGI.escape(id),
    ]
  end
end
