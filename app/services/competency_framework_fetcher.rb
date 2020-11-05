require "cgi"

class CompetencyFrameworkFetcher
  COMPETENCY_FRAMEWORKS_PATH = "/api/competency_frameworks"

  METAMODEL_PARSERS = {
    "https://ocf-collab.org/concepts/6ad27cff-5832-4b3d-bd3e-892208b80cad" => CompetencyFrameworkParsers::Asn::Framework,
    "https://ocf-collab.org/concepts/f63b9a67-543a-49ab-b5ed-8296545c1db5" => CompetencyFrameworkParsers::Case::Framework,
  }

  attr_reader :id

  def initialize(id:)
    @id = id
  end

  def competency_framework
    @competency_framework ||= competency_framework_parser.new(body: response_data).competency_framework
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
      COMPETENCY_FRAMEWORKS_PATH,
      CGI.escape(id),
    ]
  end

  def competency_framework_parser
    METAMODEL_PARSERS[competency_framework_metadata.provider_meta_model]
  end

  def competency_framework_metadata
    @competency_framework_metadata ||= CompetencyFrameworkMetadataFetcher.new(id: id).competency_framework_metadata
  end
end
