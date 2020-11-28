require "cgi"

class CompetencyFrameworkFetcher
  COMPETENCY_FRAMEWORKS_PATH = "/api/competency_frameworks"

  attr_reader :tenant, :id, :requested_metamodel

  def initialize(tenant:, id:, requested_metamodel: nil)
    @tenant = tenant
    @id = id
    @requested_metamodel = requested_metamodel
  end

  def competency_framework
    @competency_framework ||= competency_framework_parser.new(body: response_data).competency_framework
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
    @response ||= oauth2_token.get(path, params: params)
  end

  def oauth2_token
    oauth2_client.client_credentials.get_token
  end

  def oauth2_client
    @oauth2_client ||= TenantOauth2Client.new(tenant: tenant)
  end

  def path
    "%s/%s/asset_file" % [
      COMPETENCY_FRAMEWORKS_PATH,
      CGI.escape(id),
    ]
  end

  def params
    if requested_metamodel.blank?
      return nil
    end

    {
      metamodel: requested_metamodel,
    }
  end

  def competency_framework_parser
    metamodel.competency_framework_parser
  end

  def metamodel
    @metamodel ||= Metamodels.from_concept_url(metamodel_concept_url)
  end

  def metamodel_concept_url
    requested_metamodel || competency_framework_metadata.provider_meta_model
  end

  def competency_framework_metadata
    @competency_framework_metadata ||= CompetencyFrameworkMetadataFetcher.new(
      tenant: tenant,
      id: id,
    ).competency_framework_metadata
  end
end
